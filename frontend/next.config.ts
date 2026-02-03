import type { NextConfig } from "next"

const nextConfig: NextConfig = {
    /* config options here */
    output: "standalone",

    // Increase body size limit for Server Actions and API routes (for PDF uploads)
    experimental: {
        serverActions: {
            bodySizeLimit: "50mb",
        },
    },
}

export default nextConfig
