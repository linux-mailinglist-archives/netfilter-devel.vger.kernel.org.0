Return-Path: <netfilter-devel+bounces-11665-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Nh0OS3f1GnzyAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11665-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 12:40:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C03AD0A3
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEDF2303E100
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328193A9DAF;
	Tue,  7 Apr 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcVTfgJg"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF33AA195;
	Tue,  7 Apr 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558370; cv=none; b=C2C7IDTbgsETpHNboVUXySOnWXaUK9GRCR0oQAGAoeoVWyA1WRdYr0qor6b7gPzLsitkEn0TCPG/Wz6ypWO5Q9V1wutDoXV0+aHmPHSnzyq+xDM/80MuZkh1d3rMZ1OAkxKWRoErcLJGHwmDohrIX7rlpcbm9cmVHPeecwomF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558370; c=relaxed/simple;
	bh=r10VBvcXoM3Z4eQBWU/o9X8JVvhzleGLD98YRMI0yKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk8p8i1oxJsZF21vIK5S+v4+wl4NiCS0TTaqbgQZ422P5ddmodj6Kf933lW9MZGKR6Cwa48XL5QE2SsCsEBQKrbrcEWzzqO9P0KKvtr0n+JTWHC3kDX+jqxQM/Ae3j0ZoJpYRLYqtlSLQ6niWvFFUvZONrhxO87HRA7D5IMpuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcVTfgJg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775558369; x=1807094369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r10VBvcXoM3Z4eQBWU/o9X8JVvhzleGLD98YRMI0yKw=;
  b=WcVTfgJg+RcR72E2pusmjbes60OKX0pINm3j8zwgIPL4Kbu7WiPE3bid
   qw7pI0uwTTezah7KRNvpZ9FcUrpwq7BUff/t+Tx1hOG4ZnLPDEOy4gN4w
   YScfpykcy5qJm5ZM95vVfGBTtFjK/l/czmm56IStj3eHhsrSXvtDjpq8a
   uOH9OkcwuvaxcdNNTzI0B6EAivhm9hX1trvMZIs2hKn9ZM1Fubk9Bwec/
   4hxfb33WC3h1Es6RkzEojTLuaFT24Y+rS3Y4offAiKRqVuDuqWP8riP+O
   XyAiZ6EL6sECP6q/JeLIn8omyZq/L/xB405qpyQvQ5VseG0AIdSpV9VKD
   A==;
X-CSE-ConnectionGUID: gA11lOzHS+6SQamat3vQJw==
X-CSE-MsgGUID: p5G8FkT2R5eM1cN3F+sEJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="94098390"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="94098390"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 03:39:28 -0700
X-CSE-ConnectionGUID: 8qZIApI1QCSNvqiYkzcIAw==
X-CSE-MsgGUID: nWMeLn2zQW6R8ABdGEZsNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="228405589"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Apr 2026 03:39:23 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wA3q3-000000000Tp-494i;
	Tue, 07 Apr 2026 10:39:19 +0000
Date: Tue, 7 Apr 2026 18:38:32 +0800
From: kernel test robot <lkp@intel.com>
To: Yingnan Zhang <342144303@qq.com>, horms@verge.net.au, ja@ssi.bg
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org, Yingnan Zhang <342144303@qq.com>
Subject: Re: [PATCH net v2] ipvs: fix MTU check for GSO packets in tunnel mode
Message-ID: <202604071825.Sh4Y1fMi-lkp@intel.com>
References: <tencent_CA2C1C219C99D315086BE55E8654AF7E6009@qq.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CA2C1C219C99D315086BE55E8654AF7E6009@qq.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11665-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,qq.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,verge.net.au,ssi.bg];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: A84C03AD0A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yingnan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yingnan-Zhang/ipvs-fix-MTU-check-for-GSO-packets-in-tunnel-mode/20260407-141549
base:   net/main
patch link:    https://lore.kernel.org/r/tencent_CA2C1C219C99D315086BE55E8654AF7E6009%40qq.com
patch subject: [PATCH net v2] ipvs: fix MTU check for GSO packets in tunnel mode
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260407/202604071825.Sh4Y1fMi-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260407/202604071825.Sh4Y1fMi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604071825.Sh4Y1fMi-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> net/netfilter/ipvs/ip_vs_xmit.c:115:2: warning: non-void function does not return a value in all control paths [-Wreturn-type]
     115 |         } else if (skb->len > mtu &&
         |         ^
>> net/netfilter/ipvs/ip_vs_xmit.c:115:4: error: expected identifier or '('
     115 |         } else if (skb->len > mtu &&
         |           ^
   net/netfilter/ipvs/ip_vs_xmit.c:119:2: error: expected identifier or '('
     119 |         return false;
         |         ^
>> net/netfilter/ipvs/ip_vs_xmit.c:120:1: error: extraneous closing brace ('}')
     120 | }
         | ^
   1 warning and 3 errors generated.


vim +115 net/netfilter/ipvs/ip_vs_xmit.c

   104	
   105	static inline bool
   106	__mtu_check_toobig_v6(const struct sk_buff *skb, u32 mtu)
   107	{
   108		if (IP6CB(skb)->frag_max_size) {
   109			/* frag_max_size tell us that, this packet have been
   110			 * defragmented by netfilter IPv6 conntrack module.
   111			 */
   112			if (IP6CB(skb)->frag_max_size > mtu)
   113				return true; /* largest fragment violate MTU */
   114		}
 > 115		} else if (skb->len > mtu &&
   116			   !(skb_is_gso(skb) && skb_gso_validate_network_len(skb, mtu))) {
   117			return true; /* Packet size violate MTU size */
   118		}
   119		return false;
 > 120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

