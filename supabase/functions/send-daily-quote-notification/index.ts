
// // // // @ts-ignore
// // // export const config = {
// // //   verify_jwt: false,
// // // };

// // // import "jsr:@supabase/functions-js/edge-runtime.d.ts";
// // // import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// // // /* ================= GOOGLE AUTH ================= */

// // // function pemToArrayBuffer(pem: string): ArrayBuffer {
// // //   const clean = pem
// // //     .replace("-----BEGIN PRIVATE KEY-----", "")
// // //     .replace("-----END PRIVATE KEY-----", "")
// // //     .replace(/\n/g, "");

// // //   const binary = atob(clean);
// // //   const buffer = new ArrayBuffer(binary.length);
// // //   const view = new Uint8Array(buffer);

// // //   for (let i = 0; i < binary.length; i++) {
// // //     view[i] = binary.charCodeAt(i);
// // //   }
// // //   return buffer;
// // // }

// // // async function getAccessToken(sa: any): Promise<string> {
// // //   const now = Math.floor(Date.now() / 1000);

// // //   const header = { alg: "RS256", typ: "JWT" };
// // //   const payload = {
// // //     iss: sa.client_email,
// // //     scope: "https://www.googleapis.com/auth/firebase.messaging",
// // //     aud: sa.token_uri,
// // //     iat: now,
// // //     exp: now + 3600,
// // //   };

// // //   const encode = (obj: any) =>
// // //     btoa(JSON.stringify(obj))
// // //       .replace(/\+/g, "-")
// // //       .replace(/\//g, "_")
// // //       .replace(/=+$/, "");

// // //   const unsignedJWT = `${encode(header)}.${encode(payload)}`;

// // //   const key = await crypto.subtle.importKey(
// // //     "pkcs8",
// // //     pemToArrayBuffer(sa.private_key),
// // //     { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
// // //     false,
// // //     ["sign"]
// // //   );

// // //   const signature = await crypto.subtle.sign(
// // //     "RSASSA-PKCS1-v1_5",
// // //     key,
// // //     new TextEncoder().encode(unsignedJWT)
// // //   );

// // //   const jwt =
// // //     unsignedJWT +
// // //     "." +
// // //     btoa(String.fromCharCode(...new Uint8Array(signature)))
// // //       .replace(/\+/g, "-")
// // //       .replace(/\//g, "_")
// // //       .replace(/=+$/, "");

// // //   const res = await fetch(sa.token_uri, {
// // //     method: "POST",
// // //     headers: { "Content-Type": "application/x-www-form-urlencoded" },
// // //     body: new URLSearchParams({
// // //       grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
// // //       assertion: jwt,
// // //     }),
// // //   });

// // //   const data = await res.json();
// // //   if (!data.access_token) {
// // //     throw new Error("Failed to get Firebase access token");
// // //   }

// // //   return data.access_token;
// // // }

// // // /* ================= TIME HELPERS ================= */

// // // function pad(n: number) {
// // //   return n.toString().padStart(2, "0");
// // // }

// // // function formatHHmm(d: Date) {
// // //   return `${pad(d.getHours())}:${pad(d.getMinutes())}`;
// // // }

// // // /* ================= EDGE FUNCTION ================= */

// // // Deno.serve(async () => {
// // //   try {
// // //     /* 🔍 ENV CHECK (CRITICAL DEBUG) */
// // //     console.log("ENV CHECK:", {
// // //       hasUrl: !!Deno.env.get("SUPABASE_URL"),
// // //       hasServiceKey: !!Deno.env.get("SUPABASE_SERVICE_ROLE_KEY"),
// // //       hasFCM: !!Deno.env.get("FCM_SERVICE_ACCOUNT"),
// // //     });

// // //     const supabase = createClient(
// // //       Deno.env.get("SUPABASE_URL")!,
// // //       Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
// // //     );

// // //     /* 🔐 Firebase service account */
// // //     const rawSA = Deno.env.get("FCM_SERVICE_ACCOUNT");
// // //     if (!rawSA) throw new Error("FCM_SERVICE_ACCOUNT secret missing");

// // //     const serviceAccount = JSON.parse(rawSA);
// // //     const accessToken = await getAccessToken(serviceAccount);

// // //     /* ================= TIME (IST) ================= */

// // //     const utcNow = new Date();
// // //     const istNow = new Date(utcNow.getTime() + 330 * 60 * 1000);

// // //     const today = istNow.toLocaleDateString("en-CA"); // YYYY-MM-DD

// // //     const currentTime = formatHHmm(istNow);
// // //     const prevMinute = formatHHmm(
// // //       new Date(istNow.getTime() - 60 * 1000)
// // //     );
// // //     const nextMinute = formatHHmm(
// // //       new Date(istNow.getTime() + 60 * 1000)
// // //     );

// // //     console.log("TIME WINDOW (IST):", {
// // //       prevMinute,
// // //       currentTime,
// // //       nextMinute,
// // //     });

// // //     /* ================= DAILY QUOTE ================= */

// // //     const { data: quote, error: quoteError } = await supabase
// // //       .from("quotes")
// // //       .select("quote, name")
// // //       .eq("is_daily", true)
// // //       .limit(1)
// // //       .maybeSingle();

// // //     if (quoteError) throw quoteError;

// // //     if (!quote) {
// // //       return new Response(
// // //         JSON.stringify({
// // //           success: true,
// // //           reason: "No daily quote",
// // //           time_checked: currentTime,
// // //         }),
// // //         { headers: { "Content-Type": "application/json" } }
// // //       );
// // //     }

// // //     /* ================= USERS MATCHING TIME ================= */

// // //     const { data: users, error: usersError } = await supabase
// // //       .from("user_notification_settings")
// // //       .select("user_id")
// // //       .eq("enabled", true)
// // //       .in("notify_time", [prevMinute, currentTime, nextMinute]);

// // //     if (usersError) throw usersError;

// // //     if (!users || users.length === 0) {
// // //       return new Response(
// // //         JSON.stringify({
// // //           success: true,
// // //           reason: "No users this minute",
// // //           time_checked: currentTime,
// // //         }),
// // //         { headers: { "Content-Type": "application/json" } }
// // //       );
// // //     }

// // //     /* ================= SEND FCM ================= */

// // //     let sentCount = 0;

// // //     for (const user of users) {
// // //       const { data: tokenRow } = await supabase
// // //         .from("device_tokens")
// // //         .select("fcm_token")
// // //         .eq("user_id", user.user_id)
// // //         .maybeSingle();

// // //       if (!tokenRow?.fcm_token) continue;

// // //       const fcmRes = await fetch(
// // //         `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
// // //         {
// // //           method: "POST",
// // //           headers: {
// // //             Authorization: `Bearer ${accessToken}`,
// // //             "Content-Type": "application/json",
// // //           },
// // //           body: JSON.stringify({
// // //             message: {
// // //               token: tokenRow.fcm_token,
// // //               notification: {
// // //                 title: "Quote of the Day",
// // //                 body: `${quote.quote} — ${quote.name}`,
// // //               },
// // //               android: {
// // //                 priority: "high",
// // //                 notification: {
// // //                   channel_id: "high_importance_channel",
// // //                 },
// // //               },
// // //             },
// // //           }),
// // //         }
// // //       );

// // //       if (!fcmRes.ok) {
// // //         console.error("FCM ERROR:", await fcmRes.text());
// // //         continue;
// // //       }

// // //       await supabase
// // //         .from("notification_logs")
// // //         .upsert(
// // //           {
// // //             user_id: user.user_id,
// // //             sent_date: today,
// // //           },
// // //           {
// // //             onConflict: "user_id,sent_date",
// // //             ignoreDuplicates: true,
// // //           }
// // //         );

// // //       sentCount++;
// // //     }

// // //     return new Response(
// // //       JSON.stringify({
// // //         success: true,
// // //         users_notified: sentCount,
// // //         time_checked: currentTime,
// // //       }),
// // //       { headers: { "Content-Type": "application/json" } }
// // //     );

// // //   } catch (e: any) {
// // //     console.error("EDGE ERROR:", e.message);
// // //     return new Response(
// // //       JSON.stringify({
// // //         success: false,
// // //         error: e.message,
// // //       }),
// // //       { status: 500 }
// // //     );
// // //   }
// // // });
// // export const config = {
// //   verify_jwt: false,
// // };

// // import "jsr:@supabase/functions-js/edge-runtime.d.ts";
// // import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// // /* ================= GOOGLE AUTH ================= */

// // function pemToArrayBuffer(pem: string): ArrayBuffer {
// //   const clean = pem
// //     .replace("-----BEGIN PRIVATE KEY-----", "")
// //     .replace("-----END PRIVATE KEY-----", "")
// //     .replace(/\n/g, "");

// //   const binary = atob(clean);
// //   const buffer = new ArrayBuffer(binary.length);
// //   const view = new Uint8Array(buffer);

// //   for (let i = 0; i < binary.length; i++) {
// //     view[i] = binary.charCodeAt(i);
// //   }
// //   return buffer;
// // }

// // async function getAccessToken(sa: any): Promise<string> {
// //   const now = Math.floor(Date.now() / 1000);

// //   const header = { alg: "RS256", typ: "JWT" };
// //   const payload = {
// //     iss: sa.client_email,
// //     scope: "https://www.googleapis.com/auth/firebase.messaging",
// //     aud: sa.token_uri,
// //     iat: now,
// //     exp: now + 3600,
// //   };

// //   const encode = (obj: any) =>
// //     btoa(JSON.stringify(obj))
// //       .replace(/\+/g, "-")
// //       .replace(/\//g, "_")
// //       .replace(/=+$/, "");

// //   const unsignedJWT = `${encode(header)}.${encode(payload)}`;

// //   const key = await crypto.subtle.importKey(
// //     "pkcs8",
// //     pemToArrayBuffer(sa.private_key),
// //     { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
// //     false,
// //     ["sign"]
// //   );

// //   const signature = await crypto.subtle.sign(
// //     "RSASSA-PKCS1-v1_5",
// //     key,
// //     new TextEncoder().encode(unsignedJWT)
// //   );

// //   const jwt =
// //     unsignedJWT +
// //     "." +
// //     btoa(String.fromCharCode(...new Uint8Array(signature)))
// //       .replace(/\+/g, "-")
// //       .replace(/\//g, "_")
// //       .replace(/=+$/, "");

// //   const res = await fetch(sa.token_uri, {
// //     method: "POST",
// //     headers: { "Content-Type": "application/x-www-form-urlencoded" },
// //     body: new URLSearchParams({
// //       grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
// //       assertion: jwt,
// //     }),
// //   });

// //   const data = await res.json();
// //   if (!data.access_token) {
// //     throw new Error("Failed to get Firebase access token");
// //   }

// //   return data.access_token;
// // }

// // /* ================= TIME HELPERS ================= */

// // function pad(n: number) {
// //   return n.toString().padStart(2, "0");
// // }

// // function formatHHmm(d: Date) {
// //   return `${pad(d.getHours())}:${pad(d.getMinutes())}`;
// // }

// // /* ================= EDGE FUNCTION ================= */

// // Deno.serve(async () => {
// //   try {
// //     const supabase = createClient(
// //       Deno.env.get("SUPABASE_URL")!,
// //       Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
// //     );

// //     /* 🔐 Firebase */
// //     const serviceAccount = JSON.parse(
// //       Deno.env.get("FCM_SERVICE_ACCOUNT")!
// //     );
// //     const accessToken = await getAccessToken(serviceAccount);

// //     /* ================= IST TIME ================= */

// //     const utcNow = new Date();
// //     const istNow = new Date(utcNow.getTime() + 330 * 60 * 1000);

// //     const today = istNow.toLocaleDateString("en-CA");
// //     const currentTime = formatHHmm(istNow);
// //     const prevMinute = formatHHmm(new Date(istNow.getTime() - 60000));
// //     const nextMinute = formatHHmm(new Date(istNow.getTime() + 60000));

// //     /* ======================================================
// //        1️⃣ ENSURE DAILY QUOTE EXISTS
// //     ====================================================== */

// //     const { data: existingDaily } = await supabase
// //       .from("quotes")
// //       .select("id")
// //       .eq("is_daily", true)
// //       .eq("last_used_at", today)
// //       .maybeSingle();

// //     if (!existingDaily) {
// //       await supabase
// //         .from("quotes")
// //         .update({ is_daily: false })
// //         .eq("is_daily", true);

// //       let { data: quote } = await supabase
// //         .rpc("get_random_unused_quote")
// //         .maybeSingle();

// //       if (!quote) {
// //         await supabase.from("quotes").update({ last_used_at: null });
// //         const res = await supabase
// //           .rpc("get_random_unused_quote")
// //           .maybeSingle();
// //         if (!res.data) throw new Error("No quotes available");
// //         quote = res.data;
// //       }

// //       await supabase
// //         .from("quotes")
// //         .update({
// //           is_daily: true,
// //           last_used_at: today,
// //         })
// //         .eq("id", quote.id);
// //     }

// //     /* ================= FETCH DAILY QUOTE ================= */

// //     const { data: quote } = await supabase
// //       .from("quotes")
// //       .select("quote, name")
// //       .eq("is_daily", true)
// //       .limit(1)
// //       .maybeSingle();

// //     if (!quote) {
// //       return new Response(
// //         JSON.stringify({ success: true, reason: "No daily quote" }),
// //         { headers: { "Content-Type": "application/json" } }
// //       );
// //     }

// //     /* ================= USERS MATCHING TIME ================= */

// //     const { data: users } = await supabase
// //       .from("user_notification_settings")
// //       .select("user_id, notify_time")
// //       .eq("enabled", true)
// //       .in("notify_time", [prevMinute, currentTime, nextMinute]);

// //     if (!users || users.length === 0) {
// //       return new Response(
// //         JSON.stringify({ success: true, reason: "No users this minute" }),
// //         { headers: { "Content-Type": "application/json" } }
// //       );
// //     }

// //     /* ================= SEND FCM ================= */

// //     let sentCount = 0;

// //     for (const user of users) {
// //       const { data: tokenRow } = await supabase
// //         .from("device_tokens")
// //         .select("fcm_token")
// //         .eq("user_id", user.user_id)
// //         .maybeSingle();

// //       if (!tokenRow?.fcm_token) continue;

// //       // 🔥 OPTION 2 LOGIC: check by (user + date + notify_time)
// //       const { data: alreadySent } = await supabase
// //         .from("notification_logs")
// //         .select("id")
// //         .eq("user_id", user.user_id)
// //         .eq("sent_date", today)
// //         .eq("notify_time", user.notify_time)
// //         .maybeSingle();

// //       if (alreadySent) continue;

// //       await fetch(
// //         `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
// //         {
// //           method: "POST",
// //           headers: {
// //             Authorization: `Bearer ${accessToken}`,
// //             "Content-Type": "application/json",
// //           },
// //           body: JSON.stringify({
// //             message: {
// //               token: tokenRow.fcm_token,
// //               notification: {
// //                 title: "Quote of the Day",
// //                 body: `${quote.quote} — ${quote.name}`,
// //               },
// //             },
// //           }),
// //         }
// //       );

// //       await supabase.from("notification_logs").insert({
// //         user_id: user.user_id,
// //         sent_date: today,
// //         notify_time: user.notify_time,
// //       });

// //       sentCount++;
// //     }

// //     return new Response(
// //       JSON.stringify({
// //         success: true,
// //         users_notified: sentCount,
// //         date: today,
// //       }),
// //       { headers: { "Content-Type": "application/json" } }
// //     );

// //   } catch (e: any) {
// //     return new Response(
// //       JSON.stringify({ success: false, error: e.message }),
// //       { status: 500 }
// //     );
// //   }
// // });
// export const config = {
//   verify_jwt: false,
// };

// import "jsr:@supabase/functions-js/edge-runtime.d.ts";
// import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// /* ================= GOOGLE AUTH ================= */

// function pemToArrayBuffer(pem: string): ArrayBuffer {
//   const clean = pem
//     .replace("-----BEGIN PRIVATE KEY-----", "")
//     .replace("-----END PRIVATE KEY-----", "")
//     .replace(/\n/g, "");

//   const binary = atob(clean);
//   const buffer = new ArrayBuffer(binary.length);
//   const view = new Uint8Array(buffer);

//   for (let i = 0; i < binary.length; i++) {
//     view[i] = binary.charCodeAt(i);
//   }
//   return buffer;
// }

// async function getAccessToken(sa: any): Promise<string> {
//   const now = Math.floor(Date.now() / 1000);

//   const header = { alg: "RS256", typ: "JWT" };
//   const payload = {
//     iss: sa.client_email,
//     scope: "https://www.googleapis.com/auth/firebase.messaging",
//     aud: sa.token_uri,
//     iat: now,
//     exp: now + 3600,
//   };

//   const encode = (obj: any) =>
//     btoa(JSON.stringify(obj))
//       .replace(/\+/g, "-")
//       .replace(/\//g, "_")
//       .replace(/=+$/, "");

//   const unsignedJWT = `${encode(header)}.${encode(payload)}`;

//   const key = await crypto.subtle.importKey(
//     "pkcs8",
//     pemToArrayBuffer(sa.private_key),
//     { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
//     false,
//     ["sign"]
//   );

//   const signature = await crypto.subtle.sign(
//     "RSASSA-PKCS1-v1_5",
//     key,
//     new TextEncoder().encode(unsignedJWT)
//   );

//   const jwt =
//     unsignedJWT +
//     "." +
//     btoa(String.fromCharCode(...new Uint8Array(signature)))
//       .replace(/\+/g, "-")
//       .replace(/\//g, "_")
//       .replace(/=+$/, "");

//   const res = await fetch(sa.token_uri, {
//     method: "POST",
//     headers: { "Content-Type": "application/x-www-form-urlencoded" },
//     body: new URLSearchParams({
//       grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
//       assertion: jwt,
//     }),
//   });

//   const data = await res.json();
//   if (!data.access_token) {
//     throw new Error("Failed to get Firebase access token");
//   }

//   return data.access_token;
// }

// /* ================= TIME HELPERS ================= */

// function pad(n: number) {
//   return n.toString().padStart(2, "0");
// }

// function formatHHmm(d: Date) {
//   return `${pad(d.getHours())}:${pad(d.getMinutes())}`;
// }

// /* ================= EDGE FUNCTION ================= */

// Deno.serve(async () => {
//   try {
//     const supabase = createClient(
//       Deno.env.get("SUPABASE_URL")!,
//       Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
//     );

//     /* 🔐 Firebase */
//     const serviceAccount = JSON.parse(
//       Deno.env.get("FCM_SERVICE_ACCOUNT")!
//     );
//     const accessToken = await getAccessToken(serviceAccount);

//     /* ================= IST DATE ================= */

//     const utcNow = new Date();
//     const istNow = new Date(utcNow.getTime() + 330 * 60 * 1000);
//     const today = istNow.toLocaleDateString("en-CA");

//     /* ======================================================
//        🔥 DAILY QUOTE LOGIC (FIXED – ALWAYS ROTATES)
//     ====================================================== */

//     // 1️⃣ Clear previous daily quote (ALWAYS)
//     await supabase
//       .from("quotes")
//       .update({ is_daily: false })
//       .eq("is_daily", true);

//     // 2️⃣ Pick truly random unused quote
//     let { data: picked } = await supabase
//       .rpc("get_random_unused_quote")
//       .maybeSingle();

//     // 3️⃣ Reset pool if exhausted
//     if (!picked) {
//       await supabase.from("quotes").update({ last_used_at: null });

//       const res = await supabase
//         .rpc("get_random_unused_quote")
//         .maybeSingle();

//       if (!res.data) throw new Error("No quotes available");
//       picked = res.data;
//     }

//     // 4️⃣ Mark as today's quote
//     await supabase
//       .from("quotes")
//       .update({
//         is_daily: true,
//         last_used_at: today,
//       })
//       .eq("id", picked.id);

//     /* ================= FETCH DAILY QUOTE ================= */

//     const { data: quote } = await supabase
//       .from("quotes")
//       .select("quote, name")
//       .eq("is_daily", true)
//       .limit(1)
//       .single();

//     /* ================= USERS BY TIME ================= */

//     const currentTime = formatHHmm(istNow);
//     const prevMinute = formatHHmm(new Date(istNow.getTime() - 60000));
//     const nextMinute = formatHHmm(new Date(istNow.getTime() + 60000));

//     const { data: users } = await supabase
//       .from("user_notification_settings")
//       .select("user_id, notify_time")
//       .eq("enabled", true)
//       .in("notify_time", [prevMinute, currentTime, nextMinute]);

//     if (!users || users.length === 0) {
//       return new Response(JSON.stringify({ success: true }));
//     }

//     /* ================= SEND FCM ================= */

//     let sent = 0;

//     for (const user of users) {
//       const { data: tokenRow } = await supabase
//         .from("device_tokens")
//         .select("fcm_token")
//         .eq("user_id", user.user_id)
//         .maybeSingle();

//       if (!tokenRow?.fcm_token) continue;

//       // OPTION 2: resend if notify_time changed
//       const { data: alreadySent } = await supabase
//         .from("notification_logs")
//         .select("id")
//         .eq("user_id", user.user_id)
//         .eq("sent_date", today)
//         .eq("notify_time", user.notify_time)
//         .maybeSingle();

//       if (alreadySent) continue;

//       await fetch(
//         `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
//         {
//           method: "POST",
//           headers: {
//             Authorization: `Bearer ${accessToken}`,
//             "Content-Type": "application/json",
//           },
//           body: JSON.stringify({
//             message: {
//               token: tokenRow.fcm_token,
//               notification: {
//                 title: "Quote of the Day",
//                 body: `${quote.quote} — ${quote.name}`,
//               },
//             },
//           }),
//         }
//       );

//       await supabase.from("notification_logs").insert({
//         user_id: user.user_id,
//         sent_date: today,
//         notify_time: user.notify_time,
//       });

//       sent++;
//     }

//     return new Response(
//       JSON.stringify({
//         success: true,
//         notified: sent,
//         date: today,
//       }),
//       { headers: { "Content-Type": "application/json" } }
//     );

//   } catch (e: any) {
//     return new Response(
//       JSON.stringify({ success: false, error: e.message }),
//       { status: 500 }
//     );
//   }
// });
export const config = {
  verify_jwt: false,
};

import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

/* ================= GOOGLE AUTH ================= */

function pemToArrayBuffer(pem: string): ArrayBuffer {
  const clean = pem
    .replace("-----BEGIN PRIVATE KEY-----", "")
    .replace("-----END PRIVATE KEY-----", "")
    .replace(/\n/g, "");

  const binary = atob(clean);
  const buffer = new ArrayBuffer(binary.length);
  const view = new Uint8Array(buffer);

  for (let i = 0; i < binary.length; i++) {
    view[i] = binary.charCodeAt(i);
  }
  return buffer;
}

async function getAccessToken(sa: any): Promise<string> {
  const now = Math.floor(Date.now() / 1000);

  const header = { alg: "RS256", typ: "JWT" };
  const payload = {
    iss: sa.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: sa.token_uri,
    iat: now,
    exp: now + 3600,
  };

  const encode = (obj: any) =>
    btoa(JSON.stringify(obj))
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=+$/, "");

  const unsignedJWT = `${encode(header)}.${encode(payload)}`;

  const key = await crypto.subtle.importKey(
    "pkcs8",
    pemToArrayBuffer(sa.private_key),
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"]
  );

  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    key,
    new TextEncoder().encode(unsignedJWT)
  );

  const jwt =
    unsignedJWT +
    "." +
    btoa(String.fromCharCode(...new Uint8Array(signature)))
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=+$/, "");

  const res = await fetch(sa.token_uri, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });

  const data = await res.json();
  if (!data.access_token) {
    throw new Error("Failed to get Firebase access token");
  }

  return data.access_token;
}

/* ================= TIME HELPERS ================= */

function pad(n: number) {
  return n.toString().padStart(2, "0");
}

function formatHHmm(d: Date) {
  return `${pad(d.getHours())}:${pad(d.getMinutes())}`;
}

/* ================= EDGE FUNCTION ================= */

Deno.serve(async () => {
  try {
    const supabase = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
    );

    /* 🔐 Firebase */
    const serviceAccount = JSON.parse(
      Deno.env.get("FCM_SERVICE_ACCOUNT")!
    );
    const accessToken = await getAccessToken(serviceAccount);

    /* ================= IST DATE ================= */

    const utcNow = new Date();
    const istNow = new Date(utcNow.getTime() + 330 * 60 * 1000);
    const today = istNow.toLocaleDateString("en-CA");

    /* ======================================================
       🔒 DAILY GUARD — ROTATE ONLY ONCE PER DAY
    ====================================================== */

    const { data: todayQuote } = await supabase
      .from("quotes")
      .select("id")
      .eq("last_used_at", today)
      .limit(1)
      .maybeSingle();

    if (!todayQuote) {
      // Clear yesterday
      await supabase
        .from("quotes")
        .update({ is_daily: false })
        .eq("is_daily", true);

      // Pick random unused
      let { data: picked } = await supabase
        .rpc("get_random_unused_quote")
        .maybeSingle();

      // Reset pool if exhausted
      if (!picked) {
        await supabase.from("quotes").update({ last_used_at: null });
        const res = await supabase
          .rpc("get_random_unused_quote")
          .maybeSingle();
        if (!res.data) throw new Error("No quotes available");
        picked = res.data;
      }

      await supabase
        .from("quotes")
        .update({
          is_daily: true,
          last_used_at: today,
        })
        .eq("id", picked.id);
    }

    /* ================= FETCH DAILY QUOTE ================= */

    const { data: quote } = await supabase
      .from("quotes")
      .select("quote, name")
      .eq("is_daily", true)
      .single();

    /* ================= USERS BY TIME ================= */

    const currentTime = formatHHmm(istNow);
    const prevMinute = formatHHmm(new Date(istNow.getTime() - 60000));
    const nextMinute = formatHHmm(new Date(istNow.getTime() + 60000));

    const { data: users } = await supabase
      .from("user_notification_settings")
      .select("user_id, notify_time")
      .eq("enabled", true)
      .in("notify_time", [prevMinute, currentTime, nextMinute]);

    if (!users || users.length === 0) {
      return new Response(JSON.stringify({ success: true }));
    }

    /* ================= SEND FCM (OPTION 2) ================= */

    for (const user of users) {
      const { data: tokenRow } = await supabase
        .from("device_tokens")
        .select("fcm_token")
        .eq("user_id", user.user_id)
        .maybeSingle();

      if (!tokenRow?.fcm_token) continue;

      const { data: alreadySent } = await supabase
        .from("notification_logs")
        .select("id")
        .eq("user_id", user.user_id)
        .eq("sent_date", today)
        .eq("notify_time", user.notify_time)
        .maybeSingle();

      if (alreadySent) continue;

      await fetch(
        `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${accessToken}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            message: {
              token: tokenRow.fcm_token,
              notification: {
                title: "Quote of the Day",
                body: `${quote.quote} — ${quote.name}`,
              },
            },
          }),
        }
      );

      await supabase.from("notification_logs").insert({
        user_id: user.user_id,
        sent_date: today,
        notify_time: user.notify_time,
      });
    }

    return new Response(
      JSON.stringify({ success: true, date: today }),
      { headers: { "Content-Type": "application/json" } }
    );

  } catch (e: any) {
    return new Response(
      JSON.stringify({ success: false, error: e.message }),
      { status: 500 }
    );
  }
});
