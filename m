Return-Path: <netfilter-devel+bounces-3210-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A6D94EABF
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Aug 2024 12:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FCD1C21572
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Aug 2024 10:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1508C16F0F0;
	Mon, 12 Aug 2024 10:24:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745716EBFE;
	Mon, 12 Aug 2024 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458296; cv=none; b=UF49aH7LNDk8m/LbMbQ0jpK1KDjdApNG+axZN6YaWP0arMyVGz2zIIPjrp9AjahrEwoJz5TLxLteAObLI/b/CWLJjF3OgukCxKgSBuI4vXKaQR2wQx06ofkYoBwLVKMDsJAkbfRc64sPv6+rbdoCCjMrFvbQihjALZppDpOzJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458296; c=relaxed/simple;
	bh=08Xmd7jBWI2ZS++477ywCjhiYEwCkk6o1BEwlc78jJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iM+TXZjVe1vY2Ld8L3DQEjIXcPmdRSb14NjRDboHJTfV30lpI03UgApUYDFKbij5T0swvnYEBxCtf+FiXpZVxyjuuSzAtRviF71fmmmz2TaCb8nyZDVcW3WkHocURKMcRFeIOpaY+2gMlDcWC5YRrF2IqX4Oa4KYauGXPO+Nl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,5.15.x 0/5] Netfilter fixes for -stable
Date: Mon, 12 Aug 2024 12:24:41 +0200
Message-Id: <20240812102446.369777-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

This batch contains a backport for recent fixes already upstream for 5.15.x.

The following list shows the backported patches, I am using original commit
IDs for reference:

1) b53c11664250 ("netfilter: nf_tables: set element extended ACK reporting support")

   This improves error reporting when adding more than one single element to set,
   it is not specifically fixing up a crash.

2) 7395dfacfff6 ("netfilter: nf_tables: use timestamp to check for set element timeout")

3) 3c13725f43dc ("netfilter: nf_tables: bail out if stateful expression provides no .clone")

4) fa23e0d4b756 ("netfilter: nf_tables: allow clone callbacks to sleep")

5) cff3bd012a95 ("netfilter: nf_tables: prefer nft_chain_validate")

Please, apply,
Thanks

Florian Westphal (2):
  netfilter: nf_tables: allow clone callbacks to sleep
  netfilter: nf_tables: prefer nft_chain_validate

Pablo Neira Ayuso (3):
  netfilter: nf_tables: set element extended ACK reporting support
  netfilter: nf_tables: use timestamp to check for set element timeout
  netfilter: nf_tables: bail out if stateful expression provides no .clone

 include/net/netfilter/nf_tables.h |  20 +++-
 net/netfilter/nf_tables_api.c     | 188 ++++++------------------------
 net/netfilter/nft_connlimit.c     |   4 +-
 net/netfilter/nft_counter.c       |   4 +-
 net/netfilter/nft_dynset.c        |   2 +-
 net/netfilter/nft_last.c          |   4 +-
 net/netfilter/nft_limit.c         |  14 ++-
 net/netfilter/nft_quota.c         |   4 +-
 net/netfilter/nft_set_hash.c      |   8 +-
 net/netfilter/nft_set_pipapo.c    |  18 +--
 net/netfilter/nft_set_rbtree.c    |   6 +-
 11 files changed, 90 insertions(+), 182 deletions(-)

--
2.30.2


