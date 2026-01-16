import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

Deno.serve(async (req) => {
  try {
    const { email } = await req.json();

    if (!email) {
      return new Response(
        JSON.stringify({ error: "Email is required" }),
        { status: 400 }
      );
    }

    // ✅ ADMIN CLIENT (SERVICE ROLE)
    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
    );

    // ✅ LIST USERS & CHECK EMAIL
    const { data, error } = await supabase.auth.admin.listUsers({
      perPage: 1000,
    });

    if (error) {
      console.error(error);
      return new Response(
        JSON.stringify({ error: "Admin access failed" }),
        { status: 500 }
      );
    }

    const exists = data.users.some(
      (user) => user.email?.toLowerCase() === email.toLowerCase()
    );

    return new Response(
      JSON.stringify({ exists }),
      { headers: { "Content-Type": "application/json" } }
    );

  } catch (e) {
    console.error(e);
    return new Response(
      JSON.stringify({ error: "Invalid request", details: String(e) }),
      { status: 500 }
    );
  }
});
