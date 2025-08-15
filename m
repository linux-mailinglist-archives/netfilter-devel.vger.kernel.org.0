Return-Path: <netfilter-devel+bounces-8327-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E2B28217
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Aug 2025 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4709B1D05402
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Aug 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA18267B01;
	Fri, 15 Aug 2025 14:37:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC38225791
	for <netfilter-devel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268642; cv=none; b=FnlOCgwyHWMqv7YxMrdS3twOnJgQiVHdR5RjFv7CnEZAc+BeQKkZ+pYwgZIUZUwAVULp4DMwcqt6uhyGyYEaDBPEWV2Epr9reL/zegamDYYmVLWfsLK9COBmnQC+waqfSioFLany0USnqUjhBODf1igasGIZw0NYMIltGi2TnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268642; c=relaxed/simple;
	bh=J6u5vCkZ8+clC3MgrvHjeciGiRxfY+rfkRpzCW4XEs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ED/tyhANHlxLPiogf9hksHUoaXgO54PYr+PkJSLbxsj8HFniLfy46PVljz7FAUWBNYysrGNRZZUItjjFHi/GRz3yA/LJoHu/GDwuW6YYuEQ6AcMfblF6RSanJ8z5N2C2As9dI48mDawFwfEQ90RcS0ifM1eBPm27YEWA8QT/iFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B3B4E60172; Fri, 15 Aug 2025 16:37:17 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: sbrivio@redhat.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/2] netfilter: nft_set_pipapo: speed up insertions
Date: Fri, 15 Aug 2025 16:36:56 +0200
Message-ID: <20250815143702.17272-1-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Always prefer the avx2 implementation if its available.
This greatly improves insertion performance (each insertion
checks if the new element would overlap with an existing one):

time nft -f - <<EOF
table ip pipapo {
	set s {
		typeof ip saddr . tcp dport
		flags interval
		size 800000
		elements = { 10.1.1.1 - 10.1.1.4 . 3996,
[.. 800k entries elided .. ]

before:
real    1m55.993s
user    0m2.505s
sys     1m53.296s

after:
real    0m42.586s
user    0m2.554s
sys     0m39.811s

First patch does some refactoring so the common part can be reused
for both packetpath and control plane.
Second patch alters control plane to use avx2.

Florian Westphal (2):
  netfilter: nft_set_pipapo_avx2: split lookup function in two parts
  netfilter: nft_set_pipapo: use avx2 algorithm for insertions too

 net/netfilter/nft_set_pipapo.c      |  47 ++++++++--
 net/netfilter/nft_set_pipapo_avx2.c | 127 +++++++++++++++++-----------
 net/netfilter/nft_set_pipapo_avx2.h |   4 +
 3 files changed, 122 insertions(+), 56 deletions(-)

-- 
2.49.1


