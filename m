Return-Path: <netfilter-devel+bounces-424-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0681A218
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Dec 2023 16:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1746B25BF5
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Dec 2023 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C9240C08;
	Wed, 20 Dec 2023 15:15:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AADA48CEA;
	Wed, 20 Dec 2023 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 0/2] Netfilter fixes for net
Date: Wed, 20 Dec 2023 16:15:42 +0100
Message-Id: <20231220151544.270214-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following patchset contains Netfilter fixes for net:

1) Skip set commit for deleted/destroyed sets, this might trigger
   double deactivation of expired elements.

2) Fix packet mangling from egress, set transport offset from
   mac header for netdev/egress.

Both fixes address bugs already present in several releases.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-12-20

Thanks.

----------------------------------------------------------------

The following changes since commit 8353c2abc02cf8302d5e6177b706c1879e7b833c:

  Merge branch 'check-vlan-filter-feature-in-vlan_vids_add_by_dev-and-vlan_vids_del_by_dev' (2023-12-19 13:13:59 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-12-20

for you to fetch changes up to 7315dc1e122c85ffdfc8defffbb8f8b616c2eb1a:

  netfilter: nf_tables: skip set commit for deleted/destroyed sets (2023-12-20 13:48:00 +0100)

----------------------------------------------------------------
netfilter pull request 23-12-20

----------------------------------------------------------------
Pablo Neira Ayuso (2):
      netfilter: nf_tables: set transport offset from mac header for netdev/egress
      netfilter: nf_tables: skip set commit for deleted/destroyed sets

 include/net/netfilter/nf_tables_ipv4.h | 2 +-
 net/netfilter/nf_tables_api.c          | 2 +-
 net/netfilter/nf_tables_core.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

