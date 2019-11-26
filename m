Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5310A180
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Nov 2019 16:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfKZPvb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Nov 2019 10:51:31 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:36544 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfKZPvb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:51:31 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iZd7d-0003Tn-KN; Tue, 26 Nov 2019 16:51:25 +0100
Date:   Tue, 26 Nov 2019 16:51:25 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Operation not supported when adding jump command
Message-ID: <20191126155125.GD8016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
References: <5248B312-60A9-48A7-B4CF-E00D1BDF1CD2@cisco.com>
 <20191126122110.GD795@breakpoint.cc>
 <3DBD9E39-A0DF-4A69-93CC-4344617BDB2F@cisco.com>
 <20191126153850.pblaoj4xklfz5jgv@salvia>
 <427E92A6-2FFA-47CF-BF3B-C08961C978C9@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427E92A6-2FFA-47CF-BF3B-C08961C978C9@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Serguei,

On Tue, Nov 26, 2019 at 03:47:49PM +0000, Serguei Bezverkhi (sbezverk) wrote:
> I totally get it that it is not possible in theory, but the matter of fact is in kubernetes somehow it works, maybe in some cases this check is not enforced, I do not know. If you are interested to investigate it further, please let me know as I said I have a cluster with these 2 rules configured.

In another case I noticed that user-defined chains are a way to
circumvent these types of functional restrictions. If that's good or bad
is up to you to decide. ;)

Regarding the desired functionality, I guess you're wandering the
sinkhole-filled plains of undefined behaviour.

Cheers, Phil
