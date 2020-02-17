Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8514F16169B
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Feb 2020 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgBQPst (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Feb 2020 10:48:49 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:47588 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbgBQPst (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:48:49 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1j3idZ-00013Y-PV; Mon, 17 Feb 2020 16:48:45 +0100
Date:   Mon, 17 Feb 2020 16:48:45 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     sbezverk <sbezverk@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Proposing to add a structure to UserData
Message-ID: <20200217154845.GY20005@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, sbezverk <sbezverk@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
References: <169CDFEB-A792-4063-AEC5-05B1714AED91@gmail.com>
 <20200217144034.GC19559@breakpoint.cc>
 <A1C979C6-C703-4013-A536-47758175E8A8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A1C979C6-C703-4013-A536-47758175E8A8@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Serguei,

On Mon, Feb 17, 2020 at 10:42:48AM -0500, sbezverk wrote:
> Thank you for letting me know, I checked golang unix package and I did not find definition for NFTNL_UDATA_RULE_COMMENT.  That explains why I did not use it.
> Could you please point me where UDATA relate types and subtypes are defined, so I could replicate them in go.

Please check libnftnl/udata.h. In general, all NFTNL_* named defines
belong to libnftnl.

Cheers, Phil
