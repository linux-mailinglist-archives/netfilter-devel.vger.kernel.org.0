Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E475646BB
	for <lists+netfilter-devel@lfdr.de>; Sun,  3 Jul 2022 12:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiGCKb4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 3 Jul 2022 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGCKb4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 3 Jul 2022 06:31:56 -0400
X-Greylist: delayed 2351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Jul 2022 03:31:51 PDT
Received: from outgoing7.flk.host-h.net (outgoing7.flk.host-h.net [188.40.212.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2DD6345
        for <netfilter-devel@vger.kernel.org>; Sun,  3 Jul 2022 03:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
        To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
        sender:bcc; bh=2xBFCcQ0Px55tJUZAoKyep9LgQW2tO+o4qFS3S25N0M=; b=cE7NUUuD66zihY
        tOwlwYtFXMR3MNxZ+rovpOTLYZWUrZZIkA1CfnMzrcNyC2OXdq9JZO4leCbDOt4C2ID4HV7Q5twrc
        4fu/ZaWKAo1oPTxwdEA/43gRcjSZQcawcXQag1sgGT4f7x9Am2BYSoSDGssaVCc1nny2wKD7rsdcY
        T0O3I68ExzMAWukUXixdib43hIt6ZrOFocJ3Dkuu3PdwqaKQ/cWiHZTmJ1julHgAq2jMEpMu4j9cO
        KxnNSgcbupiFH3Kj/+x8BDjdrExj4LJq7ehnIqZRJCOgSp8YVwKCWhjCBYApiolrpq+pmZ+dmYk3I
        NofCC+oiWyah2OTrQzFA==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam1-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1o7wHJ-0007nD-7O; Sun, 03 Jul 2022 11:52:35 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
        by www31.flk1.host-h.net with esmtpa (Exim 4.92)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1o7wHG-0008Cx-MS; Sun, 03 Jul 2022 11:52:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 03 Jul 2022 11:52:30 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     netfilter-devel@vger.kernel.org
Cc:     justin.swartz@risingedge.co.za, rkolchmeyer@google.com,
        fw@strlen.de, pablo@netfilter.org
Subject: [PATCH resend] ebtables: extend the 'static' build target fix.
In-Reply-To: <20220625081441.13323-1-justin.swartz@risingedge.co.za>
References: <20220625081441.13323-1-justin.swartz@risingedge.co.za>
Message-ID: <42ed3ff1408e811918f138e1f1aefec1@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00456048098403)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9GFC4sOlVaWbJn0suSq8XFPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xntEluci+0hyorrNrHYHDzyr7MsDDHqPd/CLhJt64naRdA
 5v8pC2VCBVt5bHO0FJZCLdtTZy6NS8co4brrOZMMIaRbzeTp3BU4MrzM0qbxqs51FfwbPW8G6lVN
 KK4YOu2ixUAhT4FotEH/iPo957J1ZpZmyaxDI4r6A80scQc+XgTJsjWw5+0eZIpQIcK9yrTJeXoU
 xPozdon+5NjDz4Lpjd12v0hRQV2TuWFKPYIZhdEijaOYwIo3VWtNfh+T9pFLMDgu+QDVxvufaery
 DXAy8U54yHbe0U2Q73dIPYtLRTa3ez3cHoqTWBKuYika620V8bsd7WYc4sS5nxHe02gIZsN/DZ4i
 BHU1jKlc4dIeTtVzfBpUNIJbCsp5zJU0MGPpxOsB8gG0slV7ra6jI4BSJGlDdAt5iE2wWUUtBv7R
 wyGL9OyxAMsMu5TiHOeDBqW2s3BysOB3xpjrd5YzJziOi2bznHJ53CHS5fL+CC61pCZsm4iYatgr
 Ye8fqbmOW/RWLiQnxfywIDC9lZJ3ggMIX0iUqFrXcSXq1PMB6qws/qFfbJCeQvjdrdga95yZyODo
 E/5Q/KZPWPqZqJjO3oRhuTNa7IVsbMNf4F0zLZ5qoWiSg2N4Io7udrmMcPXxKJH6q/obeNp/dhvh
 HGNFOg8aehn9y6na5dJ8yk+LGdDCpwEiRQv+PVjjwa+Z5RFCOMTjUmZB3byRPIA5X1eVx5QA3igk
 FenBVf36/WXDCgxJ9Ufc+cONOZosr3fUW6KX8BrEPNbZQpCR3KegtTOX63sEnXgz5kNf6qHiP1F9
 RDuwk6GlFBV91TZd1YlfxlEZ4KBMwntsduNBxKPaTpE5L8d4XtLSRONyf/B0O0MyJjs3E+a5snvy
 UDKRzod43GUvzJgCpxegjDoP3kEGX61kK9szljgWI6KDH29KFP1cNjTUdIpfvHvO1CUYniP/BXuE
 pal+pvlHhV6a5QjptwQBGybQTi2w8S0/k7XOgp7ipJmXvi2+Hs9hQLEoLrZFClclPheGH7phbOjl
 Im7xGwbwuG222pb4i4DTkMZeMiNI9JSIyVssHYIVS/ha87SlzBqiWdduUSkw4uZmYUb1+mji+YZ6
X-Report-Abuse-To: spam@antispammaster.host-h.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Assign "-all-static" (instead of "-static") to "static_LDFLAGS" in
Makefile.am, as libtool will only produce a static binary if it is
explicitly told that all of the linked libraries should be static.

BEFORE

$ file static
static: ELF 32-bit LSB pie executable, Intel 80386, version 1 (SYSV),
         dynamically linked, interpreter /lib/ld-musl-i386.so.1,
         not stripped

AFTER

$ file static
static: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV),
         statically linked, not stripped

REFERENCE

"Another common situation where static linking is desirable is in
  creating a standalone binary. Use libtool to do the linking and
  add the -all-static flag."  --  Libtool Manual, Section 3.7

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
  Makefile.am | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index b246064..d011919 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -51,7 +51,7 @@ ebtablesd_LDADD = libebtc.la
  ebtables_legacy_restore_SOURCES = ebtables-restore.c
  ebtables_legacy_restore_LDADD = libebtc.la
  static_SOURCES = ebtables-standalone.c $(libebtc_la_SOURCES)
-static_LDFLAGS = -static
+static_LDFLAGS = -all-static
  examples_ulog_test_ulog_SOURCES = examples/ulog/test_ulog.c 
getethertype.c

  daemon: ebtablesd ebtablesu
