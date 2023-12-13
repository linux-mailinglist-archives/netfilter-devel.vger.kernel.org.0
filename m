Return-Path: <netfilter-devel+bounces-323-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC25811A67
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 18:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0AD1F21157
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B693A8CC;
	Wed, 13 Dec 2023 17:07:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD5D5
	for <netfilter-devel@vger.kernel.org>; Wed, 13 Dec 2023 09:06:57 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rDShE-0001Y2-2W; Wed, 13 Dec 2023 18:06:56 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/3] src: make set-merging less zealous
Date: Wed, 13 Dec 2023 18:06:42 +0100
Message-ID: <20231213170650.13451-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got a large corpus of various crashes in the set internals code
tripping over expressions that should not exist, e.g. a range expression
with a symbolic expression.

From initial investigation it looks like to root cause is the same,
we have back-to-back declarations of the same set name, evaluation
is returning errors, but we instist to continue evaluation.

Then, we try to merge set elements and end up merging
such a 'redefined set' with an erroneous one.

This series adds an initial assertion which helped to make
crashes easier to backtrace.

Second patch adds a 'errors' flag to struct set and raises
it once we saw soemthing funky.

Patch 3 also sets/uses this when evaluating the set itself.

Alternative would be to make the lowlevel code more robust
of these kinds of issues, but that might take a while
to fix, also because this oce is partially not able to
indicate errors.

Florian Westphal (3):
  intervals: BUG on prefix expressions without value
  src: do not merge a set with a erroneous one
  evaluate: don't assert if set->data is NULL

 include/rule.h                                  |  2 ++
 src/evaluate.c                                  | 17 +++++++++++++++--
 src/intervals.c                                 |  5 ++++-
 .../nft-f/expr_evaluate_mapping_no_data_assert  |  4 ++++
 .../bogons/nft-f/invalid_range_expr_type_binop  | 12 ++++++++++++
 5 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 tests/shell/testcases/bogons/nft-f/expr_evaluate_mapping_no_data_assert
 create mode 100644 tests/shell/testcases/bogons/nft-f/invalid_range_expr_type_binop

-- 
2.41.0


