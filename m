Return-Path: <netfilter-devel+bounces-196-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC8806CB4
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 11:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3500EB20DAC
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DEF30345;
	Wed,  6 Dec 2023 10:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUbsYFiK"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A293A3;
	Wed,  6 Dec 2023 02:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701860016; x=1733396016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aRGjhVeGjiXnLRUiM9RdDijTdgGjuQNT9KkxsDvh1bc=;
  b=AUbsYFiK8na0wSmettfg2tkfSJJuT/C8LJrXJ9Z7PThqMihIZOHr/dDh
   yHtnjIumiGex6rBKEToecDQeQTX2vYG/SiD6kkkTM3b1PdEFCKYjhWRuR
   fb9QIwpoaaIcTG5emfNor2SDGhx0fDut67/HT60AgFlJi4eYLJqmRE9Le
   ezmz6RdNtxEGtbFdP8t2Jz1mCzegZxLRq9mU2R1n5965ni86VpOMWt8Fh
   RillIclZxxZRilGHTL5TmN8pwc8J/9zLFGEymx7QqyKnR09/uRNFgK0nC
   skdcIcxDmp/z3JpB5K4INsLWR/1PD9ONuU3ccOBZD8ARaFi8wAI1862vH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="460533516"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="460533516"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 02:53:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889302886"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="889302886"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2023 02:53:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rApWy-000Af2-2v;
	Wed, 06 Dec 2023 10:53:28 +0000
Date: Wed, 6 Dec 2023 18:52:50 +0800
From: kernel test robot <lkp@intel.com>
To: Lev Pantiukhin <kndrvt@yandex-team.ru>
Cc: oe-kbuild-all@lists.linux.dev, mitradir@yandex-team.ru,
	Lev Pantiukhin <kndrvt@yandex-team.ru>,
	Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH] ipvs: add a stateless type of service and a stateless
 Maglev hashing scheduler
Message-ID: <202312061823.O99VPf15-lkp@intel.com>
References: <20231204152020.472247-1-kndrvt@yandex-team.ru>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204152020.472247-1-kndrvt@yandex-team.ru>

Hi Lev,

kernel test robot noticed the following build warnings:

[auto build test WARNING on horms-ipvs-next/master]
[also build test WARNING on horms-ipvs/master linus/master v6.7-rc4 next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lev-Pantiukhin/ipvs-add-a-stateless-type-of-service-and-a-stateless-Maglev-hashing-scheduler/20231204-232344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs-next.git master
patch link:    https://lore.kernel.org/r/20231204152020.472247-1-kndrvt%40yandex-team.ru
patch subject: [PATCH] ipvs: add a stateless type of service and a stateless Maglev hashing scheduler
config: microblaze-randconfig-r123-20231206 (https://download.01.org/0day-ci/archive/20231206/202312061823.O99VPf15-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312061823.O99VPf15-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061823.O99VPf15-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/netfilter/ipvs/ip_vs_ctl.c:972:42: sparse: sparse: restricted __be32 degrades to integer
   net/netfilter/ipvs/ip_vs_ctl.c:972:60: sparse: sparse: restricted __be32 degrades to integer
   net/netfilter/ipvs/ip_vs_ctl.c:976:48: sparse: sparse: restricted __be32 degrades to integer
   net/netfilter/ipvs/ip_vs_ctl.c:976:70: sparse: sparse: restricted __be32 degrades to integer
>> net/netfilter/ipvs/ip_vs_ctl.c:976:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] diff @@     got unsigned int @@
   net/netfilter/ipvs/ip_vs_ctl.c:976:30: sparse:     expected restricted __be32 [usertype] diff
   net/netfilter/ipvs/ip_vs_ctl.c:976:30: sparse:     got unsigned int
>> net/netfilter/ipvs/ip_vs_ctl.c:978:41: sparse: sparse: cast from restricted __be32
   net/netfilter/ipvs/ip_vs_ctl.c:1532:27: sparse: sparse: dereference of noderef expression

vim +972 net/netfilter/ipvs/ip_vs_ctl.c

   962	
   963	static int __ip_vs_mh_compare_dests(struct list_head *a, struct list_head *b)
   964	{
   965		struct ip_vs_dest *dest_a = list_entry(a, struct ip_vs_dest, n_list);
   966		struct ip_vs_dest *dest_b = list_entry(b, struct ip_vs_dest, n_list);
   967		unsigned int i = 0;
   968		__be32 diff;
   969	
   970		switch (dest_a->af) {
   971		case AF_INET:
 > 972			return (int)(dest_a->addr.ip - dest_b->addr.ip);
   973	
   974		case AF_INET6:
   975			for (; i < ARRAY_SIZE(dest_a->addr.ip6); i++) {
 > 976				diff = dest_a->addr.ip6[i] - dest_b->addr.ip6[i];
   977				if (diff)
 > 978					return (int)diff;
   979			}
   980		}
   981	
   982		return 0;
   983	}
   984	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

