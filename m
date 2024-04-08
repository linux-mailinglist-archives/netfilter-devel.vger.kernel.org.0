Return-Path: <netfilter-devel+bounces-1669-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8C89CD66
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Apr 2024 23:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4144B22FB4
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Apr 2024 21:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924B147C89;
	Mon,  8 Apr 2024 21:19:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4909147C83;
	Mon,  8 Apr 2024 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611177; cv=none; b=mJ/3thwjXiGfyZDjrZKd+9CyIS3sK9ffAW/AXHE9GOmeP3VbMC7ai5w8JQJznSjmfxCE8m8736cnjl3wXHo3a3Vvc23LFQqh2KPDAOxANjtOWdKyGUCgcF7tHUss4secDi49HwGwb+EueUScqyxgDeVJ/m9xkrs0+MM0DQ5kV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611177; c=relaxed/simple;
	bh=bMCEbODdLtzNgshqei4/DarRlIf3QMdIlCu5ZWZ2MQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q9InWgvICHBC0PnIkpB5cKlkp1HvMdeiITZFEn5TLWYTt4EccFeHVS01JrpJ36Y9MGnwJKFw+eEu8USKlRz9xvPNJoD1mU1Ul0v+3rTFp4kZBGvnnUiMxxN9BMr0WIO3Or9oH/Db9CQ3VYxg1Hi0EOETP/QJ/pBRBYRtvCoDh4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: [PATCH -stable,5.15.x 0/3] Netfilter fixes for -stable
Date: Mon,  8 Apr 2024 23:19:27 +0200
Message-Id: <20240408211930.312070-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

This batch contains a backport for recent fixes already upstream for 6.1.x,
to add them on top of your enqueued patches:

a45e6889575c ("netfilter: nf_tables: release batch on table validation from abort path")
0d459e2ffb54 ("netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path")
1bc83a019bbe ("netfilter: nf_tables: discard table flag update with pending basechain deletion")

Please, apply, thanks.

Pablo Neira Ayuso (3):
  netfilter: nf_tables: release batch on table validation from abort path
  netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path
  netfilter: nf_tables: discard table flag update with pending basechain deletion

 net/netfilter/nf_tables_api.c | 47 +++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 11 deletions(-)

--
2.30.2


