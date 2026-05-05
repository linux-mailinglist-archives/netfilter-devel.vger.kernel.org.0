Return-Path: <netfilter-devel+bounces-12421-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDkSNgE3+Wki6wIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12421-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 05 May 2026 02:17:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF94C5313
	for <lists+netfilter-devel@lfdr.de>; Tue, 05 May 2026 02:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B99D73008CA3
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 May 2026 00:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773151A4F2F;
	Tue,  5 May 2026 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="t8OVjDZa"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313218AE2;
	Tue,  5 May 2026 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940218; cv=none; b=S4l4+PMbRu+qkgFGvHSFoOZSTEVuGnA90eJ16OC5AHKDYtFKKBBHGn2mujbSMNPo/2pyc70fjBxowxp+dZivOEdi+vPTGahugCMM5zcxNaF1W6ql8fHOCroF+6Mmqdv9V3NedK7XRFeGPMkr7PaM7Cdn8DyWKtP4nBIRLIwpsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940218; c=relaxed/simple;
	bh=UNxALb+Dt7zF8llTxqRMtAkCTjbwyKA1lrwTZvcUPyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOHxxNARl4WFiC1k0eG/selVex0ZFuJBP3VJi+j8wsGkzEchAjH6Tcsv9v9yCcmoaV9KT9M6x82dz83abJfMtkOuT511N4vgsJJ40VTfxrgkAP+Aj2h6gDNrbv6IoXX6sJp0c+1+I5zpTCJpoDsYSER7npTF9Nskbs8DeCV7BNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=t8OVjDZa; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 18936600B5;
	Tue,  5 May 2026 02:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777940214;
	bh=bgGHn5+0+sbpL8I1AC+vXMVXTSi39aCvCP+GFCAztRU=;
	h=From:To:Cc:Subject:Date:From;
	b=t8OVjDZamp/k48WIplWLdLdYOzTCM0xFCxcpG1GypBbiQrkt53COMSmyKjnsN/eDs
	 bkkWbiLlPDalKLQl5M3qIRwbmAOB9KXAsBiP5nvQGW531Adstvy6Zch0z4MKm2wzV9
	 zMTCOSFhV6rmuy58vUaYAf0KKGu/dZdfk6nTQmE71Rk2nYj0TezfD1CuhOnU56o4uu
	 jmeYda7TGSh/XMR7J4hVLvd1IKIJuBomAikcMniQy58Lhp38EEP+xQpwNv+HcAXC1I
	 HS5NkH4rnLJVmtJsRLzFMZlnbbgsm+LGmaxt+bOEXz+MlaXky10nPXNFCDarl/GNTb
	 /SFBqZfI2n7dA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org,
	ja@ssi.bg,
	longman@redhat.com,
	lvs-devel@vger.kernel.org
Subject: [PATCH net 0/8] IPVS fixes for net
Date: Tue,  5 May 2026 02:16:40 +0200
Message-ID: <20260505001648.360569-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CFEF94C5313
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12421-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

The following batch contains IPVS fixes for net to address issues
from the latest net-next pull request.

Julian Anastasov made the following summary:

1-3) Fixes for the recently added resizable hash tables
 
4) dest from trash can be leaked if ip_vs_start_estimator() fails
 
5) fixed races and locking for the estimation kthreads
 
6) fix for wrong roundup_pow_of_two() usage in the resizable hash
   tables
 
7-8) v2 of the changes from Waiman Long to properly guard against
  the housekeeping_cpumask() updates:
 
  https://lore.kernel.org/netfilter-devel/20260331165015.2777765-1-longman@redhat.com/
 
  I added missing Fixes tag. The original description:
 
  Since commit 041ee6f3727a ("kthread: Rely on HK_TYPE_DOMAIN for preferred
  affinity management"), the HK_TYPE_KTHREAD housekeeping cpumask may no
  longer be correct in showing the actual CPU affinity of kthreads that
  have no predefined CPU affinity. As the ipvs networking code is still
  using HK_TYPE_KTHREAD, we need to make HK_TYPE_KTHREAD reflect the
  reality.
 
  This patch series makes HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
  and uses RCU to protect access to the HK_TYPE_KTHREAD housekeeping
  cpumask.

Julian plans to post a nf-next patch to limit the connections by using
"conn_max" sysctl. With Simon Horman, they agreed that this is an old
problem that we do not have a limit of connections and it is not a
stopper for this patchset.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-05-05

Thanks.

----------------------------------------------------------------

The following changes since commit bd3a4795d5744f59a1f485379f1303e5e606f377:

  selftests: tls: add test for data loss on small pipe (2026-05-02 18:27:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-26-05-05

for you to fetch changes up to 8f78b749f3da0f43990490b4c1193b5ede3eec0a:

  sched/isolation: Make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN (2026-05-05 01:52:55 +0200)

----------------------------------------------------------------
netfilter pull request 26-05-05

----------------------------------------------------------------
Julian Anastasov (6):
      ipvs: fixes for the new ip_vs_status info
      ipvs: fix races around the conn_lfactor and svc_lfactor sysctl vars
      ipvs: fix the spin_lock usage for RT build
      ipvs: do not leak dest after get from dest trash
      ipvs: fix races around est_mutex and est_cpulist
      ipvs: fix shift-out-of-bounds in ip_vs_rht_desired_size

Waiman Long (2):
      ipvs: Guard access of HK_TYPE_KTHREAD cpumask with RCU
      sched/isolation: Make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN

 include/linux/sched/isolation.h |   6 +-
 include/net/ip_vs.h             |  31 ++++++--
 net/netfilter/ipvs/ip_vs_conn.c |  76 ++++++++++---------
 net/netfilter/ipvs/ip_vs_core.c |   2 +-
 net/netfilter/ipvs/ip_vs_ctl.c  | 164 +++++++++++++++++++++++++++++-----------
 net/netfilter/ipvs/ip_vs_est.c  |  83 +++++++++++---------
 6 files changed, 241 insertions(+), 121 deletions(-)

