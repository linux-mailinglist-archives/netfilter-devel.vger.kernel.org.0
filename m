Return-Path: <netfilter-devel+bounces-13555-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G4JrDSxiRGrEtwoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13555-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 02:41:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B36E8F06
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 02:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BfzoomBw;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13555-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13555-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C3BF300E6A2
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2026 00:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86435201278;
	Wed,  1 Jul 2026 00:41:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8121C5D5E
	for <netfilter-devel@vger.kernel.org>; Wed,  1 Jul 2026 00:41:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782866469; cv=none; b=swSws541QTIEVqv3E+tswphihwIXViF5s0XwT2eGqwmkxkk1oCXfKeNz6tBArqUyqKSnO6GFA7XRVE4pO0/I4VekG9LySsfOInWQD/80KLfVq5/JPx2uqOQYkUqAkPI81z9f/ImDdhsgTrtNjuDcwti6rVBtjsrt3ubIY6OyHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782866469; c=relaxed/simple;
	bh=bSB5H2Lgxx0eXXrsvKAY67y+/J13/SxtCRAyey3sh3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+/W6L5F1T8s/r55kO16vmgy0l6bXaKvIxl49dmermPFa4bJZU442/bF+HJyXuz4I3h23rXLMloz4hhceSxn+QhNraj7q8neB8QxO1iPMGt6kEykEGYv4OB37C6RATLF31I38Teh6m8bumF7LfHvvrnfNiUVFvO4aPFoPiHNcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfzoomBw; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782866466; x=1814402466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bSB5H2Lgxx0eXXrsvKAY67y+/J13/SxtCRAyey3sh3Q=;
  b=BfzoomBwnsqODRDdZxXQZWi1qmp1FebEq2NZOu0wmWrjT/+WL2jBCw2L
   VrMaGmF5g0NbKxZ77SFU9EVaD436cEqxMUM4APGJz8oLw4VsJ+sKtgBCC
   +Q+rXlg6dlDDBu1nmRhfP1xUVY1zW1An40FHmXdb6zPJS5n69AmdKdmib
   6djHBPwMsPnJIcL4R06ymsARRcNBNArsLMO2XlsWzOoX1xzxWfst0Gh4/
   gzaTrGOUBWQdzys6iPGBQyqQ4pqc33Ydi06G+ld5hdloL82mdALJ4KUSi
   3sUWaclIWIRdCOC7Jc4Hn+EEY4H865qZX0ySugXBSsMqNwZHhGM+HiyWK
   g==;
X-CSE-ConnectionGUID: H17+YXuXR7CvEVg37E9qJA==
X-CSE-MsgGUID: jU/t01q5TIG1xWCD701fPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83463035"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83463035"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:41:06 -0700
X-CSE-ConnectionGUID: jVtlqcHmQrKq5JCC74K1Uw==
X-CSE-MsgGUID: cahsLL1mRf2kCs98l530TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="257317521"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 30 Jun 2026 17:41:04 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wej0e-000000008oF-1Kde;
	Wed, 01 Jul 2026 00:41:00 +0000
Date: Wed, 1 Jul 2026 08:40:21 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v3 nf] netfilter: nft_ct: support expectation creation
 for natted flows
Message-ID: <202607010848.Tf9MTgFt-lkp@intel.com>
References: <20260630190929.14735-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630190929.14735-1-fw@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13555-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:oe-kbuild-all@lists.linux.dev,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 303B36E8F06

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/netfilter-nft_ct-support-expectation-creation-for-natted-flows/20260701-031657
base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20260630190929.14735-1-fw%40strlen.de
patch subject: [PATCH v3 nf] netfilter: nft_ct: support expectation creation for natted flows
config: arc-randconfig-002-20260701 (https://download.01.org/0day-ci/archive/20260701/202607010848.Tf9MTgFt-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260701/202607010848.Tf9MTgFt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607010848.Tf9MTgFt-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> net/netfilter/nft_ct.c:1398:14: error: 'nft_ct_nat_follow_master' undeclared here (not in a function); did you mean 'nft_ct_get_eval_counter'?
     .expectfn = nft_ct_nat_follow_master,
                 ^~~~~~~~~~~~~~~~~~~~~~~~
                 nft_ct_get_eval_counter
>> net/netfilter/nft_ct.c:1396:37: warning: 'nft_ct_nat' defined but not used [-Wunused-variable]
    static struct nf_ct_helper_expectfn nft_ct_nat __read_mostly = {
                                        ^~~~~~~~~~


vim +1398 net/netfilter/nft_ct.c

  1395	
> 1396	static struct nf_ct_helper_expectfn nft_ct_nat __read_mostly = {
  1397		.name = "nft_ct-follow-master",
> 1398		.expectfn = nft_ct_nat_follow_master,
  1399	};
  1400	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

