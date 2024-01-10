Return-Path: <netfilter-devel+bounces-592-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89C82A122
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 20:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB653B22868
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 19:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7D4E1D6;
	Wed, 10 Jan 2024 19:42:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED574D581
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jan 2024 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nft 0/4] assorted fixes
Date: Wed, 10 Jan 2024 20:42:13 +0100
Message-Id: <20240110194217.484064-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Florian,

This in an alternative path to address the issue described here:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20240110082657.1967-2-fw@strlen.de/

(I am partially integrating this patch into 3/4 in this series).

Patch #1 fixes a bug in the set optimization with single elements, which
         results in strange ruleset listings. Concatenations are only
	 supported with sets, so let's just skip this.

Patch #2 do not fetch next key in case runaway flag is set on with
	 concatenations. I could not crash nftables with this, but
	 I found it when reviewing this code.

Patch #3 iterate over the anonymous set in set_evaluate() to validate
         consistency of elements as concat expressions. Otherwise, bail
	 out with:

  ruleset.nft:3:46-53: Error: expression is not a concatenation
               ip protocol . th dport vmap { tcp / 22 : accept, tcp . 80 : drop}
                                             ^^^^^^^^

         I extended tests to cover maps too.

I needed special error handling when set_evaluate() fails to release sets so
ASAN does not complain with incorrect memory handling, this chunk:

@@ -118,7 +119,15 @@ static struct expr *implicit_set_declaration(struct eval_ctx *ctx,
                list_add_tail(&cmd->list, &ctx->cmd->list);
        }

-       set_evaluate(ctx, set);
+       err = set_evaluate(ctx, set);
+       if (err < 0) {
+               list_del(&cmd->list);
+               if (set->flags & NFT_SET_MAP)
+                       cmd->set->init = NULL;
+
+               cmd_free(cmd);
+               return NULL;
+       }

        return set_ref_expr_alloc(&expr->location, set);
 }

Patch #4 revert a recent late sanity check which is already covered by this
	 patchset.

In general the idea is to make stricter validations from evaluation phase
to avoid propagating errors any further.

This passing tests/shell and tests/py, it might be a good idea to add more
bogons tests for concatenations with imbalanced number of components / runaway
number of components, I will follow up with a patch to extend tests
infrastructure with this.

Pablo Neira Ayuso (4):
  evaluate: skip anonymous set optimization for concatenations
  evaluate: do not fetch next expression on runaway number of concatenation components
  evaluate: bail out if anonymous concat set defines a non concat expression
  Revert "datatype: do not assert when value exceeds expected width"

 src/datatype.c                                |  6 +-
 src/evaluate.c                                | 59 +++++++++++++++----
 .../bogons/nft-f/unhandled_key_type_13_assert |  5 ++
 .../nft-f/unhandled_key_type_13_assert_map    |  5 ++
 .../nft-f/unhandled_key_type_13_assert_vmap   |  5 ++
 5 files changed, 64 insertions(+), 16 deletions(-)
 create mode 100644 tests/shell/testcases/bogons/nft-f/unhandled_key_type_13_assert
 create mode 100644 tests/shell/testcases/bogons/nft-f/unhandled_key_type_13_assert_map
 create mode 100644 tests/shell/testcases/bogons/nft-f/unhandled_key_type_13_assert_vmap

--
2.30.2


