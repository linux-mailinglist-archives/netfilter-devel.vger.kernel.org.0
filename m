Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273197191C
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jul 2019 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfGWNXe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jul 2019 09:23:34 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48434 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGWNXd (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:23:33 -0400
Received: from localhost ([::1]:33292 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hpulQ-0007w3-U6; Tue, 23 Jul 2019 15:23:32 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH v2 1/2] parser_bison: Fix for deprecated statements
Date:   Tue, 23 Jul 2019 15:23:12 +0200
Message-Id: <20190723132313.13238-2-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723132313.13238-1-phil@nwl.cc>
References: <20190723132313.13238-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Bison-3.3 started to warn about:

/home/n0-1/git/nftables/src/parser_bison.y:117.1-19: warning: deprecated directive, use ‘%define api.prefix {nft_}’ [-Wdeprecated]
    117 | %name-prefix "nft_"
        | ^~~~~~~~~~~~~~~~~~~
/home/n0-1/git/nftables/src/parser_bison.y:119.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
  119 | %pure-parser
      | ^~~~~~~~~~~~
/home/n0-1/git/nftables/src/parser_bison.y:124.1-14: warning: deprecated directive, use ‘%define parse.error verbose’ [-Wdeprecated]
  124 | %error-verbose
      | ^~~~~~~~~~~~~~

Replace the last two as suggested but leave the first one in place as
that causes compilation errors in scanner.l - flex seems not to pick up
the changed internal symbol names.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/parser_bison.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 53e669521efa0..b463a140d31ff 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -116,12 +116,12 @@ int nft_lex(void *, void *, void *);
 
 %name-prefix "nft_"
 %debug
-%pure-parser
+%define api.pure
 %parse-param		{ struct nft_ctx *nft }
 %parse-param		{ void *scanner }
 %parse-param		{ struct parser_state *state }
 %lex-param		{ scanner }
-%error-verbose
+%define parse.error verbose
 %locations
 
 %initial-action {
-- 
2.22.0

