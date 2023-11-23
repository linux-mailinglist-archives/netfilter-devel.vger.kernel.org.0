Return-Path: <netfilter-devel+bounces-11-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812E7F646E
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Nov 2023 17:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65372818F1
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Nov 2023 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA63D99A;
	Thu, 23 Nov 2023 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA62D46
	for <netfilter-devel@vger.kernel.org>; Thu, 23 Nov 2023 08:55:50 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
	(envelope-from <n0-1@orbyte.nwl.cc>)
	id 1r6CzV-0003eV-0I
	for netfilter-devel@vger.kernel.org; Thu, 23 Nov 2023 17:55:49 +0100
Date: Thu, 23 Nov 2023 17:55:49 +0100
From: Phil Sutter <phil@nwl.cc>
To: netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 0/6] Extend guided option parser for use by
 arptables
Message-ID: <ZV+EFba8u1Qp7KJq@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org
References: <20231122215301.15725-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122215301.15725-1-phil@nwl.cc>

On Wed, Nov 22, 2023 at 10:52:55PM +0100, Phil Sutter wrote:
> Patch 1 is unrelated to the remaining ones, but fits into a series about
> libxtables option parser.
> 
> Patch 2 fixes for parsing of IP addresses with arptables, patches 3 and
> 4 enable users to parse integers in a fixed base.
> 
> Patches 5 and 6 then migrate more extensions over to using the guided
> option parser.
> 
> Phil Sutter (6):
>   libxtables: Combine the two extension option mergers
>   libxtables: Fix guided option parser for use with arptables
>   libxtables: Introduce xtables_strtoul_base()
>   libxtables: Introduce struct xt_option_entry::base
>   extensions: libarpt_mangle: Use guided option parser
>   extensions: MARK: arptables: Use guided option parser

Series applied.

