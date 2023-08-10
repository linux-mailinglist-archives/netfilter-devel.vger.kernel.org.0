Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B037C7777A9
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Aug 2023 13:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjHJLze (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Aug 2023 07:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjHJLze (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:55:34 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FE1E4B
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Aug 2023 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=o19enXeRMXeiuUMV2VuHVujj52xJsBsYRn9WX5YK9Cw=; b=BzMeBIs3WAXvSgHyYGHekS8L8m
        o4BxpTNOI7rdSeUJ0wskNyrHeRkyteMXi6kmowusykkZtZzjJsAOlz6Qf8iHMaWwsYDX1Eby3ro/9
        KWRCXl1oBbsBdJXbPp2wYUMnuZg1YCge1KolyedkEshL2JEcmEZtFfNk2nukvxte4TosmLf6hKkf1
        VswCT7doYBVq72+a2nzK05pOvTaAyOdA6Q064JXbzMVSeY6+HGgpnH2h589iSVW+1FlX8C4QS/qCY
        q+NBMuucHuTou1sysxtFG0PlkJT9oIHsYJRREMdUq7aQ4W3j3jpbFdm6WfVoBjDvH/IFhgraHcHKO
        ivZxz3Xg==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qU4GK-0004nf-41
        for netfilter-devel@vger.kernel.org; Thu, 10 Aug 2023 13:55:32 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests: iptables-test: Fix command segfault reports
Date:   Thu, 10 Aug 2023 13:55:23 +0200
Message-Id: <20230810115523.28565-1-phil@nwl.cc>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Logging produced a stack trace due to undefined variable 'cmd'.

Fixes: 0e80cfea3762b ("tests: iptables-test: Implement fast test mode")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables-test.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/iptables-test.py b/iptables-test.py
index ef0a35d3daa22..6f63cdbeda9af 100755
--- a/iptables-test.py
+++ b/iptables-test.py
@@ -136,7 +136,7 @@ STDERR_IS_TTY = sys.stderr.isatty()
     # check for segfaults
     #
     if proc.returncode == -11:
-        reason = "iptables-save segfaults: " + cmd
+        reason = command + " segfaults!"
         print_error(reason, filename, lineno)
         delete_rule(iptables, rule, filename, lineno, netns)
         return -1
@@ -333,8 +333,11 @@ STDERR_IS_TTY = sys.stderr.isatty()
     out, err = proc.communicate(input = restore_data)
 
     if proc.returncode == -11:
-        reason = iptables + "-restore segfaults: " + cmd
+        reason = iptables + "-restore segfaults!"
         print_error(reason, filename, lineno)
+        msg = [iptables + "-restore segfault from:"]
+        msg.extend(["input: " + l for l in restore_data.split("\n")])
+        print("\n".join(msg), file=log_file)
         return -1
 
     if proc.returncode != 0:
@@ -355,7 +358,7 @@ STDERR_IS_TTY = sys.stderr.isatty()
     out, err = proc.communicate()
 
     if proc.returncode == -11:
-        reason = iptables + "-save segfaults: " + cmd
+        reason = iptables + "-save segfaults!"
         print_error(reason, filename, lineno)
         return -1
 
-- 
2.40.0

