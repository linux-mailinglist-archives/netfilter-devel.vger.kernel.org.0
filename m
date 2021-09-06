Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016DB401E4D
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Sep 2021 18:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbhIFQbG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Sep 2021 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbhIFQbG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:31:06 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C536C061575
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Sep 2021 09:30:01 -0700 (PDT)
Received: from localhost ([::1]:42320 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mNHVP-0008DF-Vo; Mon, 06 Sep 2021 18:30:00 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 4/7] tests: iptables-test: Print errors to stderr
Date:   Mon,  6 Sep 2021 18:30:35 +0200
Message-Id: <20210906163038.15381-4-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906163038.15381-1-phil@nwl.cc>
References: <20210906163038.15381-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

No big deal, just pass the extra parameter to the four error print
calls.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables-test.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/iptables-test.py b/iptables-test.py
index 01966f916957b..1790da3d0b074 100755
--- a/iptables-test.py
+++ b/iptables-test.py
@@ -47,7 +47,7 @@ def print_error(reason, filename=None, lineno=None):
     Prints an error with nice colors, indicating file and line number.
     '''
     print(filename + ": " + Colors.RED + "ERROR" +
-        Colors.ENDC + ": line %d (%s)" % (lineno, reason))
+        Colors.ENDC + ": line %d (%s)" % (lineno, reason), file=sys.stderr)
 
 
 def delete_rule(iptables, rule, filename, lineno):
@@ -368,11 +368,12 @@ def main():
         EXECUTEABLE = "xtables-nft-multi"
 
     if os.getuid() != 0:
-        print("You need to be root to run this, sorry")
+        print("You need to be root to run this, sorry", file=sys.stderr)
         return
 
     if not args.netns and not args.no_netns and not spawn_netns():
-        print("Cannot run in own namespace, connectivity might break")
+        print("Cannot run in own namespace, connectivity might break",
+              file=sys.stderr)
 
     if not args.host:
         os.putenv("XTABLES_LIBDIR", os.path.abspath(EXTENSIONS_PATH))
@@ -388,7 +389,7 @@ def main():
     try:
         log_file = open(LOGFILE, 'w')
     except IOError:
-        print("Couldn't open log file %s" % LOGFILE)
+        print("Couldn't open log file %s" % LOGFILE, file=sys.stderr)
         return
 
     if args.filename:
-- 
2.33.0

