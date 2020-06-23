Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5F20488A
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2020 06:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgFWENM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jun 2020 00:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgFWENM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:13:12 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D46C061573
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jun 2020 21:13:11 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 23 Jun 2020 05:35:03 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     netfilter-devel@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [libnf_ct PATCH 4/8] Fix incorrect snprintf size calculation
Date:   Tue, 23 Jun 2020 05:34:39 +0200
Message-Id: <20200623033443.18184-5-dxld@darkboxed.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623033443.18184-1-dxld@darkboxed.org>
References: <20200623033443.18184-1-dxld@darkboxed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-report: Spam detection software, running on the system "Janet.clients.dxld.at",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  The previous BUFFER_SIZE() call already updated the remaining
    'len'. So there is no need to subtract 'size' again. While this just makes
    the buffer appear smaller than it is, which is mostly harmless, [...] 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-Spam-score: -0.0
X-Spam-bar: /
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The previous BUFFER_SIZE() call already updated the remaining 'len'. So
there is no need to subtract 'size' again. While this just makes the buffer
appear smaller than it is, which is mostly harmless, the subtraction might
underflow as 'size > len' is not checked like BUFFER_SIZE() does.

Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
---
 src/conntrack/snprintf_default.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/conntrack/snprintf_default.c b/src/conntrack/snprintf_default.c
index 2f2f918..d00c5cb 100644
--- a/src/conntrack/snprintf_default.c
+++ b/src/conntrack/snprintf_default.c
@@ -108,7 +108,7 @@ static int __snprintf_address_ipv6(char *buf,
 	if (!inet_ntop(AF_INET6, &dst, tmp, sizeof(tmp)))
 		return -1;
 
-	ret = snprintf(buf+offset, len-size, "%s=%s ", dst_tag, tmp);
+	ret = snprintf(buf+offset, len, "%s=%s ", dst_tag, tmp);
 	BUFFER_SIZE(ret, size, len, offset);
 
 	return size;
-- 
2.20.1

