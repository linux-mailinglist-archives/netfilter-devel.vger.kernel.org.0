Return-Path: <netfilter-devel+bounces-12645-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kzRQJONFCmrsygQAu9opvQ
	(envelope-from <netfilter-devel+bounces-12645-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 00:49:07 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD53564358
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 00:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A14D3008D30
	for <lists+netfilter-devel@lfdr.de>; Sun, 17 May 2026 22:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0939032E6BB;
	Sun, 17 May 2026 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARGHxaww"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D651302753
	for <netfilter-devel@vger.kernel.org>; Sun, 17 May 2026 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779058144; cv=none; b=F2SMBU3s1Dtm5T2Vg8YI400ycT7t/bSuZIml4/KZ93xwIfRi1f9vWXWaDUjzVN8/O1hlS6OLuw1VaS+FeF2lVJDPpcXH2Hazf8xms7BEbuMPYFkMd2PSiIJK01+GYISCrdm5+COcb82meGeLnZcAquYrj7FE0WrZX+kwGAaJzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779058144; c=relaxed/simple;
	bh=v1uzcZXIpIusUpA8l3CJUR0mziixlHdGbcBVWNsuKrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgwKvhwGJd5YEL0YVluqvLFFZhiPCczu9kW7r9fY/VKSRZwmQwOS4XdQTelVBsV1ctOCbGy9twFDRXLtjeDl2hzUt016vLEUA7hGiQQnIq+Mkvm83TZluP/oeXfvS8XOP/fqy6Unox6hN3qzpTofJn8qsV7k3riEOkuiKZ1c8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARGHxaww; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779058143; x=1810594143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v1uzcZXIpIusUpA8l3CJUR0mziixlHdGbcBVWNsuKrw=;
  b=ARGHxawwYaYYJilWbOXWZPKUeK0qdSnuyuA1GAA0UsATZwI8hZs6HYq5
   z3pt5UM6IHYFJQeFGQUBhEluTLOPxsYAubTUU+tjcwNqfx0G7Ps8PhMjD
   OFhDWTQVbIPYRzlEWMOOeLMp1weILwpHMxBl6GBgcTXiqvzxemR5HxAjz
   u/ldZWYsLmOtXAjhnVXW5w9G1nvqSos5dmA3kGWj8PRWGXXTNTU728cK2
   b7wIq3eg0GGr6RMkpYOmdbXRQ0fqLrdnOtVUJT3ASfpEcPI4Y9HdhH/zr
   MzZPE6SWwH0WMSTV0t/HeiSMjjkaJrLFS01LKh1SrHgHI2tnOnRVNz455
   A==;
X-CSE-ConnectionGUID: gPVqIumAR8Cy26W/hSDv7A==
X-CSE-MsgGUID: 6ySLxULySH+ra23xHgnysg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="91018754"
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; 
   d="scan'208";a="91018754"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 15:49:02 -0700
X-CSE-ConnectionGUID: Q+8snC4+Q7STZg72+NRF4w==
X-CSE-MsgGUID: GRScEY86T0WOaP6MBqYPhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,240,1770624000"; 
   d="scan'208";a="243250578"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 May 2026 15:48:59 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wOkI3-0000000020M-3JBn;
	Sun, 17 May 2026 22:48:55 +0000
Date: Mon, 18 May 2026 06:48:32 +0800
From: kernel test robot <lkp@intel.com>
To: Ren Wei <n05ec@lzu.edu.cn>, netfilter-devel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pablo@netfilter.org, fw@strlen.de,
	phil@nwl.cc, kaber@trash.net, jengelh@medozas.de,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, tonanli66@gmail.com, n05ec@lzu.edu.cn
Subject: Re: [PATCH nf 1/1] netfilter: nf_dup: preserve socket ownership on
 egress duplicates
Message-ID: <202605180624.d7iEj7Xu-lkp@intel.com>
References: <7b2643cdbf92aab1eb0ce00f2c6e7151839cbe40.1778945319.git.tonanli66@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b2643cdbf92aab1eb0ce00f2c6e7151839cbe40.1778945319.git.tonanli66@gmail.com>
X-Rspamd-Queue-Id: DFD53564358
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12645-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,netfilter.org,strlen.de,nwl.cc,trash.net,medozas.de,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Hi Ren,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ren-Wei/netfilter-nf_dup-preserve-socket-ownership-on-egress-duplicates/20260517-203809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/7b2643cdbf92aab1eb0ce00f2c6e7151839cbe40.1778945319.git.tonanli66%40gmail.com
patch subject: [PATCH nf 1/1] netfilter: nf_dup: preserve socket ownership on egress duplicates
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260518/202605180624.d7iEj7Xu-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260518/202605180624.d7iEj7Xu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605180624.d7iEj7Xu-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__sock_wfree" [net/ipv4/netfilter/nf_dup_ipv4.ko] undefined!
>> ERROR: modpost: "tcp_wfree" [net/ipv4/netfilter/nf_dup_ipv4.ko] undefined!
>> ERROR: modpost: "__sock_wfree" [net/ipv6/netfilter/nf_dup_ipv6.ko] undefined!
>> ERROR: modpost: "tcp_wfree" [net/ipv6/netfilter/nf_dup_ipv6.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

