Return-Path: <netfilter-devel+bounces-11474-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMnRMCVNxmmgIAUAu9opvQ
	(envelope-from <netfilter-devel+bounces-11474-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2026 10:25:57 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67759341AE7
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2026 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F3D4307CC3B
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2026 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4EE3CAE99;
	Fri, 27 Mar 2026 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNTY/ZqA"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D53CBE7F;
	Fri, 27 Mar 2026 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603500; cv=none; b=NNnaWOeuka6Bvt/pNkp/X1svDGKz1dV9nZ+pJo2ZLeVUN7YL3GR21SpWYC/ve+tdCKTGVbNXjFBR8zApVCtIxxb2WYvddYUsA6D23xMuZVdQ7Mj2DCqxck3ZLFRsEIP7ldDtk78vDXYTuV2Hs10/2bYBGHogs/jwYrEa/uNjtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603500; c=relaxed/simple;
	bh=qJm6pDnzsN9A+Wle9K581NgqCbPN5k4qbYPIvW7F/aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFSxk0aveP4LcOqAMl9cg3QHkbgc3v40AFuTvZE2pxOB8aeLw+ShZjtgZHali2Lj1pNSnT75GwDMa2vS+udGvV+FQFibRj9UySePG3p2wfV2M5SCZT5XufEEvMYHsVY8rHgIdVwWNg+jE+9CWKMIfRTmoHgvPCXvsPD9gea3nyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNTY/ZqA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774603498; x=1806139498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qJm6pDnzsN9A+Wle9K581NgqCbPN5k4qbYPIvW7F/aM=;
  b=lNTY/ZqAmo/ccEgD+XgxH3Qygr6VqFr73ue8zZB1pz/IA85DLNc40Nil
   GrDJc2MwwcR5+ZUVYhfPWxxVE5HCD4HM5xtqf0E7g4+G+DiUP4DCRtDJU
   0XpN3g/MCSaFd8I/0gjDnWnGOgpKrpHiW/xihWFY8CTUsOtjS/H5Q02Rw
   olYQiMT3kHF3fq0HIu18OKOx55VWGfkmcVqgK8+9J7stwdh1nDsBc2vyr
   CfDfJTkEN9WEcLDSzV4WH1fTHLBBtShf2FbzSPPjQfn3U+yIgqiWRvcQG
   rm8yFlWVudXgtb7rGrWszwDT2UHwXqhDN58a0Gp2JgtksPX+46K5lJdqD
   Q==;
X-CSE-ConnectionGUID: jBQqzcj0RwCStpP4M8LxiA==
X-CSE-MsgGUID: Nh3eU0gmRmqfX/YVwafGKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79577823"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="79577823"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:24:57 -0700
X-CSE-ConnectionGUID: tzczHYdqTAyV/N9Z5YCVnA==
X-CSE-MsgGUID: uQP1u3pARJyk5ylijKxydA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="230191724"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:24:52 -0700
Date: Fri, 27 Mar 2026 11:24:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] netfilter: nf_conntrack_h323: Correct indentation
 when H323_TRACE defined
Message-ID: <acZM4qwEtWqANece@ashevche-desk.local>
References: <20260326201819.3900-1-david.laight.linux@gmail.com>
 <acWWBxmPd_BNqUHF@chamomile>
 <20260326221809.0b99df3f@pumpkin>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326221809.0b99df3f@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11474-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 67759341AE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:18:09PM +0000, David Laight wrote:
> On Thu, 26 Mar 2026 21:24:39 +0100
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Thu, Mar 26, 2026 at 08:18:19PM +0000, david.laight.linux@gmail.com wrote:
> > > 
> > > The trace lines are indented using PRINT("%*.s", xx, " ").
> > > Userspace will treat this as "%*.0s" and will output no characters
> > > when 'xx' is zero, the kernel treats it as "%*s" and will output
> > > a single ' ' - which is probably what is intended.
> > > 
> > > Change all the formats to "%*s" removing the default precision.
> > > This gives a single space indent when level is zero.  
> > 
> > Do you have a setup using this helper? Or you just found this via
> > visual inspection?
> 
> Found with grep looking for places which might be affected by 'fixing'
> the kernel printf code to be POSIX compliant.

Do we have the respective test case in printf_kunit?

-- 
With Best Regards,
Andy Shevchenko



