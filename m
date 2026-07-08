Return-Path: <netfilter-devel+bounces-13725-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BYOyG9AuTmo4EwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13725-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 13:04:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A87724A2E
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 13:04:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KdkPdMqi;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13725-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13725-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2723308E3BB
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3B53C0633;
	Wed,  8 Jul 2026 11:00:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90D224234
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 11:00:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508425; cv=none; b=mCVcoMwszUD2x2plTjbk2ngfATciDRutySXvi7yFyPs8IGW0ufP8bZvOur9V8Q1mFKsEG41RvLZPM9mNVG/xe4n8aA0LDgveCR/nrUbqamcbmAfr/iktgZX0v1sKrlObpo+0sxGRUyed4BRNclf1OTFYkqHnhvcAGU7Ru6iX+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508425; c=relaxed/simple;
	bh=RgFp3t0xXEJuRU59u8geFWyHTZrH6eXJzcU9jj8DX2I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qugwyBKLRBoBw+mHOKr0mP9hWIaVuq+6Tq3p1KM7m4DhAlMfaDvJpyerRCqpl+eC95kCe0aNE2mOzHjU/hT2iDzKc157Nvxm/Ejq/AEtMYino2+cc1Sp1GrgIUUqEXBJ+dmbZhXBD/TSgmZwCflgr/YvHgG5vF9OMGVfUN0tBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdkPdMqi; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783508422; x=1815044422;
  h=date:from:to:cc:subject:message-id;
  bh=RgFp3t0xXEJuRU59u8geFWyHTZrH6eXJzcU9jj8DX2I=;
  b=KdkPdMqiTv5OCwQEHOshYCMeuQXg8Vdgsl6TTo+0mmKWDjg8GFBRI9Dk
   7gvKgXXgF7HwYUCbUsDJHLw6C4YOFccmsg1pke99Tt5oJHYuPg6jzNFGF
   Xq71Tox1lToyw5rDe+3Sl8UM1pH0qxJU2t/bORT97vgOyADwjFTYUrsrn
   ykHU3wufSpunMX9pEgnlza3rBfn2ly/DPca57S+NTiYTb2HD5W7Bs2q0J
   u3pTx15/YESkUIE6LLjFX2jj/iJbgNd/Cq3j8ZUOafZl5t5tFWKFYNx8z
   QtMecnDbg3DIfiHHnw81hwzzapKnbOveLKxvsVtloFj0t0d6HtZTnA7ua
   A==;
X-CSE-ConnectionGUID: eQfuhfyXSrGUuJEt4Mq1Rw==
X-CSE-MsgGUID: zmp3FqhTSHySXkbhc8LaFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83279515"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83279515"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 04:00:21 -0700
X-CSE-ConnectionGUID: SvT0GAjvSmSz+aT2OvWsZw==
X-CSE-MsgGUID: EJqI0mu5TnmoQW8XBaR8og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292451236"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2026 04:00:19 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whQ0m-000000002kj-458x;
	Wed, 08 Jul 2026 11:00:16 +0000
Date: Wed, 08 Jul 2026 12:59:36 +0200
From: kernel test robot <lkp@intel.com>
To: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 Florian Westphal <fw@strlen.de>
Subject: [netfilter-nf:testing 11/20]
 net/netfilter/ipset/ip_set_hash_gen.h:379:21: warning: result of comparison
 of constant -1 with expression of type 'u8' (aka 'unsigned char') is always
 false
Message-ID: <202607081250.ODagxDyb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13725-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kadlec@netfilter.org,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:fw@strlen.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12A87724A2E

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git testing
head:   c2fbcb9151957c3d921a7441cf080e49eb13b05d
commit: a900abcb974bae821a5d4ae79ad3442808915416 [11/20] netfilter: ipset: rework cidr bookkeeping
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260708/202607081250.ODagxDyb-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260708/202607081250.ODagxDyb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607081250.ODagxDyb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/netfilter/ipset/ip_set_hash_ipportnet.c:131:
>> net/netfilter/ipset/ip_set_hash_gen.h:379:21: warning: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
     379 |         if (unlikely(found == -1))
         |                      ~~~~~ ^  ~~
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   In file included from net/netfilter/ipset/ip_set_hash_ipportnet.c:391:
>> net/netfilter/ipset/ip_set_hash_gen.h:379:21: warning: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Wtautological-constant-out-of-range-compare]
     379 |         if (unlikely(found == -1))
         |                      ~~~~~ ^  ~~
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   2 warnings generated.


vim +379 net/netfilter/ipset/ip_set_hash_gen.h

   364	
   365	static void
   366	mtype_del_cidr(struct ip_set *set, struct htype *h, u8 cidr, u8 n)
   367	{
   368		struct net_prefixes *nets, *tmp;
   369		u8 i, j, found, len = 0;
   370	
   371		spin_lock_bh(&set->lock);
   372		nets = __ipset_dereference(h->rnets[n]);
   373		for (i = 0, found = -1; i < nets->len; i++) {
   374			if (nets->nets[i].count)
   375				len++;
   376			if (nets->nets[i].cidr == cidr)
   377				found = i;
   378		}
 > 379		if (unlikely(found == -1))
   380			return;
   381		nets->nets[found].count--;
   382		if (nets->nets[found].count)
   383			goto unlock;
   384		len--;
   385		tmp = kzalloc(sizeof(struct net_prefixes) +
   386			      len * sizeof(struct net_prefix), GFP_ATOMIC);
   387		if (!tmp)
   388			/* Leave a hole */
   389			return;
   390		tmp->len = len;
   391		for (i = 0, j = 0; i < nets->len; i++) {
   392			if (!nets->nets[i].count || i == found)
   393				continue;
   394			tmp->nets[j].cidr = nets->nets[i].cidr;
   395			tmp->nets[j++].count = nets->nets[i].count;
   396		}
   397		rcu_assign_pointer(h->rnets[n], tmp);
   398		kfree_rcu(nets, rcu);
   399	unlock:
   400		spin_unlock_bh(&set->lock);
   401	}
   402	#endif
   403	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

