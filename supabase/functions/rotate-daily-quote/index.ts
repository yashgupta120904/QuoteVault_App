

// // import "jsr:@supabase/functions-js/edge-runtime.d.ts";
// // import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// // Deno.serve(async () => {
// //   try {
// //     const supabase = createClient(
// //       Deno.env.get("SUPABASE_URL")!,
// //       Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
// //     );

// //     // ✅ LOCAL date
// //     const today = new Date().toLocaleDateString("en-CA");

// //     // 1️⃣ Clear previous daily quote
// //     const { error: clearError } = await supabase
// //       .from("quotes")
// //       .update({ is_daily: false })
// //       .eq("is_daily", true);

// //     if (clearError) throw clearError;

// //     // 2️⃣ Pick unused quote randomly
// //     let { data: quote } = await supabase
// //       .from("quotes")
// //       .select("id")
// //       .is("last_used_at", null)
// //       .order("id", { ascending: false }) // simple shuffle alternative
// //       .limit(1)
// //       .maybeSingle();

// //     // 3️⃣ Reset if exhausted
// //     if (!quote) {
// //       const { error: resetError } = await supabase
// //         .from("quotes")
// //         .update({ last_used_at: null });

// //       if (resetError) throw resetError;

// //       const { data } = await supabase
// //         .from("quotes")
// //         .select("id")
// //         .order("id", { ascending: false })
// //         .limit(1)
// //         .maybeSingle();

// //       if (!data) throw new Error("No quotes available");
// //       quote = data;
// //     }

// //     // 4️⃣ Mark selected quote as daily
// //     const { error: updateError } = await supabase
// //       .from("quotes")
// //       .update({
// //         is_daily: true,
// //         last_used_at: today,
// //       })
// //       .eq("id", quote.id);

// //     if (updateError) throw updateError;

// //     return new Response(
// //       JSON.stringify({
// //         success: true,
// //         daily_quote_id: quote.id,
// //       }),
// //       { headers: { "Content-Type": "application/json" } }
// //     );

// //   } catch (e: any) {
// //     console.error("Rotate daily quote failed:", e);
// //     return new Response(
// //       JSON.stringify({
// //         success: false,
// //         error: e.message,
// //       }),
// //       { status: 500 }
// //     );
// //   }
// // });
// import "jsr:@supabase/functions-js/edge-runtime.d.ts";
// import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// Deno.serve(async () => {
//   const logs: string[] = [];

//   try {
//     logs.push("Function started");

//     const supabase = createClient(
//       Deno.env.get("SUPABASE_URL")!,
//       Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
//     );

//     const today = new Date().toLocaleDateString("en-CA");
//     logs.push(`Today: ${today}`);

//     // 1️⃣ Clear daily
//     const clear = await supabase
//       .from("quotes")
//       .update({ is_daily: false })
//       .eq("is_daily", true);

//     logs.push(`Clear daily affected: ${clear.count}`);

//     // 2️⃣ Find unused
//     const unused = await supabase
//       .from("quotes")
//       .select("id")
//       .is("last_used_at", null)
//       .limit(1)
//       .maybeSingle();

//     logs.push(`Unused quote: ${JSON.stringify(unused.data)}`);

//     let quoteId: string;

//     if (unused.data) {
//       quoteId = unused.data.id;
//     } else {
//       logs.push("No unused quotes, resetting...");

//       await supabase
//         .from("quotes")
//         .update({ last_used_at: null });

//       const fallback = await supabase
//         .from("quotes")
//         .select("id")
//         .limit(1)
//         .maybeSingle();

//       if (!fallback.data) throw new Error("NO QUOTES IN TABLE");

//       quoteId = fallback.data.id;
//     }

//     logs.push(`Selected quoteId: ${quoteId}`);

//     // 3️⃣ Mark daily
//     await supabase
//       .from("quotes")
//       .update({
//         is_daily: true,
//         last_used_at: today,
//       })
//       .eq("id", quoteId);

//     logs.push("Quote marked as daily");

//     return new Response(
//       JSON.stringify({ success: true, logs }),
//       { headers: { "Content-Type": "application/json" } }
//     );

//   } catch (e: any) {
//     logs.push(`ERROR: ${e.message}`);

//     return new Response(
//       JSON.stringify({ success: false, logs }),
//       { status: 500 }
//     );
//   }
// });
import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

Deno.serve(async () => {
  try {
    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
    );

    const today = new Date().toLocaleDateString("en-CA"); // YYYY-MM-DD

    // 1️⃣ Clear old daily quote
    const { error: clearError } = await supabase
      .from("quotes")
      .update({ is_daily: false })
      .eq("is_daily", true);

    if (clearError) throw clearError;

    // 2️⃣ Pick unused quote
    let { data: quote } = await supabase
      .from("quotes")
      .select("id")
      .is("last_used_at", null)
      .limit(1)
      .maybeSingle();

    // 3️⃣ Reset if all used
    if (!quote) {
      await supabase.from("quotes").update({ last_used_at: null });

      const { data } = await supabase
        .from("quotes")
        .select("id")
        .limit(1)
        .maybeSingle();

      if (!data) throw new Error("No quotes available");
      quote = data;
    }

    // 4️⃣ Mark as daily
    const { error: updateError } = await supabase
      .from("quotes")
      .update({
        is_daily: true,
        last_used_at: today,
      })
      .eq("id", quote.id);

    if (updateError) throw updateError;

    return new Response(
      JSON.stringify({
        success: true,
        daily_quote_id: quote.id,
      }),
      { headers: { "Content-Type": "application/json" } }
    );

  } catch (e: any) {
    return new Response(
      JSON.stringify({ success: false, error: e.message }),
      { status: 500 }
    );
  }
});
