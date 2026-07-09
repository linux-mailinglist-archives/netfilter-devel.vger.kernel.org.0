Return-Path: <netfilter-devel+bounces-13772-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dmI2LrpFT2o2dQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13772-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 08:54:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500672D626
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 08:54:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HBq7xuGw;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13772-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13772-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 091FE30191BA
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA93D3CF2;
	Thu,  9 Jul 2026 06:53:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2BF3CC7D8;
	Thu,  9 Jul 2026 06:53:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580001; cv=none; b=PO1CQkMFb3Ity7EJGyw6CvKqFTu5mGIHDm6grnwOlxvtVnJOGMznEUxQ3js4+rmi79x61djy5xTKaDOwlE/eeusSweagNcHEW71sK7ilJJgeTtjgTC59L0cxdKm4691HXGVF/bJNV6plBvbAVGV8xJ4TZm6PbMjU/OWRGEwsrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580001; c=relaxed/simple;
	bh=QGNQisF2MPBayaIvehXT+6AWuqILnIRGPpuPyRtE9GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUMtzZxHvsPz/UEA4yBxlTgFLGOSfk4hQ2/ZdzdoAIOvybY9TS4Kldvx+mruK8uLE/DSEoPSvrq6HSSSC6d1nWDKSFDifL7LGSJx6El+0SPeBwKJJ3YbX1CqkEM25kPew+agOT9JCJv4UPda0Cs8bbbHVZ7m+0AbUbbYaQwPKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBq7xuGw; arc=none smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783580000; x=1815116000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QGNQisF2MPBayaIvehXT+6AWuqILnIRGPpuPyRtE9GA=;
  b=HBq7xuGw364VduR9CZApZl8fIFnc5qeV/94GGz8pxv2Xzv2OyXWR4Iyk
   ZvyQdgmlun/kgzKRwqq5M0p/hduwWDAbQNHLlapLFmf9H114Dno74Edmm
   eceG5oSX7EvO+KK/e9EiVmqgc7wb2p+MkgJLWYb6AyRMbXarmOsQQwWOj
   Pxx8UxBJI3Y8yg9ZmhRtNgqEhesM1d3/tyfKrgMqajt6AZ3NZKDI2XG5c
   hKIX9SbgezrXw/qRvaPTjnp8KNpIuOGMr8/cvzmhihsGjn+Pc7L1uBc7z
   ZMqvUSaBlKjQhbn1xH80Vw46VjGhggQoJnG+zz64zIkA68IYYNRna6Du6
   A==;
X-CSE-ConnectionGUID: MFmP4kKSQICVYFIEr4wmpQ==
X-CSE-MsgGUID: sIRBDw4YSjCB6zqSMXNqyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71772653"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71772653"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 23:53:20 -0700
X-CSE-ConnectionGUID: 0vYIzVo7QxaDRr2DMkpqrg==
X-CSE-MsgGUID: Kl53URpBSTWHFzo5vQSWWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253408237"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 08 Jul 2026 23:53:16 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whicl-00000000HMd-25U4;
	Thu, 09 Jul 2026 06:53:12 +0000
Date: Thu, 9 Jul 2026 14:52:38 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <anzaki@gmail.com>, netfilter-devel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, fw@strlen.de, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: flowtable: tear down HW offloaded flows on
 FIB route changes
Message-ID: <202607091427.MRtlNy5G-lkp@intel.com>
References: <20260708205404.911832-1-anzaki@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708205404.911832-1-anzaki@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13772-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anzaki@gmail.com,m:netfilter-devel@vger.kernel.org,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:pablo@netfilter.org,m:fw@strlen.de,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1500672D626

Hi Ahmed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on netfilter-nf/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/netfilter-flowtable-tear-down-HW-offloaded-flows-on-FIB-route-changes/20260709-050000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20260708205404.911832-1-anzaki%40gmail.com
patch subject: [PATCH nf] netfilter: flowtable: tear down HW offloaded flows on FIB route changes
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260709/202607091427.MRtlNy5G-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project b3e6e6dabdc02153552a64fc74ff5c7532447eed)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260709/202607091427.MRtlNy5G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607091427.MRtlNy5G-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/netfilter/nf_flow_table_core.c:833:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     833 |                 struct fib_entry_notifier_info *fen;
         |                 ^
   net/netfilter/nf_flow_table_core.c:843:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     843 |                 struct fib6_entry_notifier_info *fen6;
         |                 ^
   2 warnings generated.


vim +833 net/netfilter/nf_flow_table_core.c

   804	
   805	/* Called with rcu_read_lock() */
   806	static int nf_flow_table_fib_event(struct notifier_block *nb,
   807					   unsigned long event, void *ptr)
   808	{
   809		struct nf_flowtable *flow_table =
   810			container_of(nb, struct nf_flowtable, fib_nb);
   811		struct fib_notifier_info *info = ptr;
   812		struct nf_flow_fib_event *ev;
   813	
   814		switch (event) {
   815		case FIB_EVENT_ENTRY_REPLACE:
   816		case FIB_EVENT_ENTRY_APPEND:
   817		case FIB_EVENT_ENTRY_DEL:
   818			break;
   819		default:
   820			return NOTIFY_DONE;
   821		}
   822	
   823		/* Skip events for an address family this table cannot hold. */
   824		if (!nf_flowtable_fib_family_match(flow_table, info->family))
   825			return NOTIFY_DONE;
   826	
   827		ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
   828		if (!ev)
   829			return NOTIFY_DONE;
   830	
   831		switch (info->family) {
   832		case NFPROTO_IPV4:
 > 833			struct fib_entry_notifier_info *fen;
   834	
   835			fen = container_of(info, struct fib_entry_notifier_info, info);
   836			ev->family     = NFPROTO_IPV4;
   837			ev->addr.ip4   = htonl(fen->dst);
   838			ev->prefix_len = fen->dst_len;
   839			break;
   840	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

