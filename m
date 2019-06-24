Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79951956
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Jun 2019 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfFXRKu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 13:10:50 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51486 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732329AbfFXRKu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:10:50 -0400
Received: from localhost ([::1]:36344 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hfSUT-0003Zk-4W; Mon, 24 Jun 2019 19:10:49 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 2/2] main: Bail if non-available JSON was requested
Date:   Mon, 24 Jun 2019 19:10:38 +0200
Message-Id: <20190624171038.24672-3-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624171038.24672-1-phil@nwl.cc>
References: <20190624171038.24672-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If user passes '-j' flag, falling back to standard syntax output
probably causes more harm than good so instead print an error message
and exit(1).

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/main.c b/src/main.c
index 9a50f30f850b2..cbfd69a42d045 100644
--- a/src/main.c
+++ b/src/main.c
@@ -277,6 +277,9 @@ int main(int argc, char * const *argv)
 		case OPT_JSON:
 #ifdef HAVE_LIBJANSSON
 			output_flags |= NFT_CTX_OUTPUT_JSON;
+#else
+			fprintf(stderr, "JSON support not compiled-in\n");
+			exit(EXIT_FAILURE);
 #endif
 			break;
 		case OPT_GUID:
-- 
2.21.0

