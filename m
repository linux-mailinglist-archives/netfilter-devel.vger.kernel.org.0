Return-Path: <netfilter-devel+bounces-617-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E8D82B3B8
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jan 2024 18:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7EB1C23B71
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jan 2024 17:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55151C2A;
	Thu, 11 Jan 2024 17:14:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525350264
	for <netfilter-devel@vger.kernel.org>; Thu, 11 Jan 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rNydM-0000re-Ni; Thu, 11 Jan 2024 18:14:24 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/2] evaluate: add more checks for '... set 1-3'
Date: Thu, 11 Jan 2024 18:14:14 +0100
Message-ID: <20240111171419.15210-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only a few statements can accept expressions with ranges, all others
will trigger an assertion in the netlink linearization path.

Add missing checks and fix the existing tproxy ones.

Florian Westphal (2):
  evaluate: tproxy: move range error checks after arg evaluation
  evaluate: add missing range checks for dup,fwd and payload statements

 src/evaluate.c                                | 100 ++++++++++--------
 .../testcases/bogons/nft-f/dup_fwd_ranges     |  14 +++
 .../testcases/bogons/nft-f/tproxy_ranges      |   8 ++
 .../nft-f/unknown_expr_type_range_assert      |   8 +-
 4 files changed, 83 insertions(+), 47 deletions(-)
 create mode 100644 tests/shell/testcases/bogons/nft-f/dup_fwd_ranges
 create mode 100644 tests/shell/testcases/bogons/nft-f/tproxy_ranges

-- 
2.41.0


