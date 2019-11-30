Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9B10DBE4
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Nov 2019 01:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfK3AEZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Nov 2019 19:04:25 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:45822 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfK3AEZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Nov 2019 19:04:25 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iaqFE-0005V7-W5; Sat, 30 Nov 2019 01:04:17 +0100
Date:   Sat, 30 Nov 2019 01:04:16 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>
Cc:     Arturo Borrero Gonzalez <arturo@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        Laura Garcia <nevola@gmail.com>
Subject: Re: Operation not supported when adding jump command
Message-ID: <20191130000416.GX8016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>,
        Arturo Borrero Gonzalez <arturo@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        Laura Garcia <nevola@gmail.com>
References: <20191127150836.GJ8016@orbyte.nwl.cc>
 <3AE9B74A-37FB-4CDA-86FB-143F506D6C77@cisco.com>
 <20191127160646.GK8016@orbyte.nwl.cc>
 <7C2EF59A-57A3-4E55-92EB-7D64BC0A8417@cisco.com>
 <20191127172210.GM8016@orbyte.nwl.cc>
 <739A821F-2645-41B2-AADA-AA6C34A17335@cisco.com>
 <20191128130814.GQ8016@orbyte.nwl.cc>
 <00B4F260-EA79-4EC1-B7B4-8A9C9D2C96DE@cisco.com>
 <20191128151511.GU8016@orbyte.nwl.cc>
 <97A2D022-C314-4DC4-813D-C319AE9A8DB3@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97A2D022-C314-4DC4-813D-C319AE9A8DB3@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Serguei,

On Fri, Nov 29, 2019 at 08:13:21PM +0000, Serguei Bezverkhi (sbezverk) wrote:
> @Phil, thanks so much for Concat suggestion. Any more points for optimization? If no, then I will move to nat portion of k8s iptables.

Looks fine to me. I don't like the mark-based verdicts, but to validate
those we need to see where the marks are set.

Cheers, Phil
