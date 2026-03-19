Return-Path: <netfilter-devel+bounces-11290-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMyCHCPEu2n1ngIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11290-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:38:43 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4152C8CE6
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61F513007BBB
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 09:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBE337472B;
	Thu, 19 Mar 2026 09:38:41 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B52D8387;
	Thu, 19 Mar 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913121; cv=none; b=Wdcahw+rt+DVC6U5mgYMIxcGyTZ8LpUAHXPnaWUp6e4jguNjA8gYKMSbQ0tyi4zJoF6xHrFrdthilPalWkDGLSGL96jfL2QXA/mSUd0wOVLnAs+wA8x9aotZqk6iYrpTkd5W2cjwlB43+eS1HEiTxsUA9qfjMlSo3Isinu7kCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913121; c=relaxed/simple;
	bh=31LK8NCeT9pZAzvqjCRETgZxFTk3AtpuJpNPq0z0hDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YI7y7SE+BCpC9Yy/caYLoZj80tmIHgpSjgr95BSyU6A/i+bVwDPEPZJq0e9rEWCkLXS33sDw8Vzzf0iqLHBgh6RLNHM0Vk/DjL28nY9LLnaR8pCx+Kk1sk5EVUelbHBesgxu6ohnRJii9Mq7yDxz1j7oT4AbRyEDCjfqDWxF7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2D3D2606E1; Thu, 19 Mar 2026 10:38:38 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 0/3] netfilter: updates for net
Date: Thu, 19 Mar 2026 10:38:31 +0100
Message-ID: <20260319093834.19933-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11290-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.124];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 0B4152C8CE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

The following patchset contains Netfilter fixes for *net*:

1) Fix UaF when netfilter bpf link goes away while nfnetlink dumps
   current hook list, we have to wait until rcu readers are gone.

2) Fix UaF when flowtable fails to register all devices, similar
   bug as 1). From Pablo Neira Ayuso.

3) nfnetlink_osf fails to properly validate option length fields.
   From Weiming Shi.

Please, pull these changes from:
The following changes since commit 7c46bd845d89ad4772573cfe0f2a56b93db75cc7:

  Merge tag 'wireless-2026-03-18' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2026-03-18 19:25:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-26-03-19

for you to fetch changes up to dbdfaae9609629a9569362e3b8f33d0a20fd783c:

  nfnetlink_osf: validate individual option lengths in fingerprints (2026-03-19 10:27:07 +0100)

----------------------------------------------------------------
netfilter pull request nf-26-03-19

----------------------------------------------------------------
Florian Westphal (1):
  netfilter: bpf: defer hook memory release until rcu readers are done

Pablo Neira Ayuso (1):
  netfilter: nf_tables: release flowtable after rcu grace period on error

Weiming Shi (1):
  nfnetlink_osf: validate individual option lengths in fingerprints

 net/netfilter/nf_bpf_link.c   |  2 +-
 net/netfilter/nf_tables_api.c |  1 +
 net/netfilter/nfnetlink_osf.c | 13 +++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.52.0

