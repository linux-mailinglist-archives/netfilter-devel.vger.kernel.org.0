Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A114794B4
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Dec 2021 20:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhLQTWf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Dec 2021 14:22:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:19182 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhLQTWf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639768955; x=1671304955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vMnKku+uBK1abc+xXoJFGXNZMEOL1blySLTgVRKuS9c=;
  b=RdaignM9hghIMi86HiqQcI29pvqCS7IcnQ33qsqYW4ay/WbMMrGKJPMH
   I9R1gzDKnhDdaFAqbeWjd3BhD2Qm+49OUs3BEVf8n2l4480z2/HpTvmwy
   V26Vm2vIfGi3QaJ+V9iqyUKXQC8VJdO0BJS5I0AKvt764c8s8D2h8XcTc
   euvaV7jHux/5CPJrqWAU0PLx4AC41q0wv7gpXv9ydj/625hdbGvkof1CN
   S30KxLvY3tyZe/GX+IcctpSJ1TksFeBRYUyvoLO9cef7/Y/oUTS/ULGRq
   DWuivxbF5rhOgyHOMxjpVtceg4UEvwa5Itce1FD9ANoDh6IX7fgPgrxo2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="240041338"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="240041338"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 11:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="683492363"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2021 11:22:32 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myIoJ-00058Y-S8; Fri, 17 Dec 2021 19:22:31 +0000
Date:   Sat, 18 Dec 2021 03:22:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, davem@davemloft.net,
        netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH nf-next,v2 5/5] netfilter: nf_tables: make counter
 support built-in
Message-ID: <202112180342.ufUrUKkP-lkp@intel.com>
References: <20211217113837.1253-5-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217113837.1253-5-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on nf/master]
[also build test WARNING on nf-next/master horms-ipvs/master v5.16-rc5 next-20211217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Pablo-Neira-Ayuso/netfilter-nf_tables-remove-rcu-read-size-lock/20211217-194033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git master
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211218/202112180342.ufUrUKkP-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/390ad4295aa6445c311abd677b653a510f621131
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Pablo-Neira-Ayuso/netfilter-nf_tables-remove-rcu-read-size-lock/20211217-194033
        git checkout 390ad4295aa6445c311abd677b653a510f621131
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/netfilter/nft_counter.c:195:6: warning: no previous prototype for 'nft_counter_eval' [-Wmissing-prototypes]
     195 | void nft_counter_eval(const struct nft_expr *expr, struct nft_regs *regs,
         |      ^~~~~~~~~~~~~~~~
>> net/netfilter/nft_counter.c:277:6: warning: no previous prototype for 'nft_counter_init_seqcount' [-Wmissing-prototypes]
     277 | void nft_counter_init_seqcount(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/nft_counter_eval +195 net/netfilter/nft_counter.c

   194	
 > 195	void nft_counter_eval(const struct nft_expr *expr, struct nft_regs *regs,
   196			      const struct nft_pktinfo *pkt)
   197	{
   198		struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
   199	
   200		nft_counter_do_eval(priv, regs, pkt);
   201	}
   202	
   203	static int nft_counter_dump(struct sk_buff *skb, const struct nft_expr *expr)
   204	{
   205		struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
   206	
   207		return nft_counter_do_dump(skb, priv, false);
   208	}
   209	
   210	static int nft_counter_init(const struct nft_ctx *ctx,
   211				    const struct nft_expr *expr,
   212				    const struct nlattr * const tb[])
   213	{
   214		struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
   215	
   216		return nft_counter_do_init(tb, priv);
   217	}
   218	
   219	static void nft_counter_destroy(const struct nft_ctx *ctx,
   220					const struct nft_expr *expr)
   221	{
   222		struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
   223	
   224		nft_counter_do_destroy(priv);
   225	}
   226	
   227	static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
   228	{
   229		struct nft_counter_percpu_priv *priv = nft_expr_priv(src);
   230		struct nft_counter_percpu_priv *priv_clone = nft_expr_priv(dst);
   231		struct nft_counter __percpu *cpu_stats;
   232		struct nft_counter *this_cpu;
   233		struct nft_counter total;
   234	
   235		nft_counter_fetch(priv, &total);
   236	
   237		cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC);
   238		if (cpu_stats == NULL)
   239			return -ENOMEM;
   240	
   241		preempt_disable();
   242		this_cpu = this_cpu_ptr(cpu_stats);
   243		this_cpu->packets = total.packets;
   244		this_cpu->bytes = total.bytes;
   245		preempt_enable();
   246	
   247		priv_clone->counter = cpu_stats;
   248		return 0;
   249	}
   250	
   251	static int nft_counter_offload(struct nft_offload_ctx *ctx,
   252				       struct nft_flow_rule *flow,
   253				       const struct nft_expr *expr)
   254	{
   255		/* No specific offload action is needed, but report success. */
   256		return 0;
   257	}
   258	
   259	static void nft_counter_offload_stats(struct nft_expr *expr,
   260					      const struct flow_stats *stats)
   261	{
   262		struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
   263		struct nft_counter *this_cpu;
   264		seqcount_t *myseq;
   265	
   266		preempt_disable();
   267		this_cpu = this_cpu_ptr(priv->counter);
   268		myseq = this_cpu_ptr(&nft_counter_seq);
   269	
   270		write_seqcount_begin(myseq);
   271		this_cpu->packets += stats->pkts;
   272		this_cpu->bytes += stats->bytes;
   273		write_seqcount_end(myseq);
   274		preempt_enable();
   275	}
   276	
 > 277	void nft_counter_init_seqcount(void)
   278	{
   279		int cpu;
   280	
   281		for_each_possible_cpu(cpu)
   282			seqcount_init(per_cpu_ptr(&nft_counter_seq, cpu));
   283	}
   284	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
