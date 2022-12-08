Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C6646F65
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Dec 2022 13:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLHMRY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Dec 2022 07:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLHMRY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:17:24 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C09E88B61;
        Thu,  8 Dec 2022 04:17:23 -0800 (PST)
Date:   Thu, 8 Dec 2022 13:17:20 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, Jiri Wiesner <jwiesner@suse.de>,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: Re: [PATCHv7 0/6] ipvs: Use kthreads for stats
Message-ID: <Y5HV0EpOrQtdU11y@salvia>
References: <20221122164604.66621-1-ja@ssi.bg>
 <Y5HTM6jY/ZRw+ar0@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5HTM6jY/ZRw+ar0@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 08, 2022 at 01:06:14PM +0100, Pablo Neira Ayuso wrote:
> On Tue, Nov 22, 2022 at 06:45:58PM +0200, Julian Anastasov wrote:
> > 	Hello,
> > 
> > 	This patchset implements stats estimation in kthread context.
> > It replaces the code that runs on single CPU in timer context every
> > 2 seconds and causing latency splats as shown in reports [1], [2], [3].
> > The solution targets setups with thousands of IPVS services, destinations
> > and multi-CPU boxes.
> 
> Series applied to nf-next, thanks.

Oh wait. I have to hold this back, I have a fundamental question:

[PATCHv7 4/6] ipvs: use kthreads for stats estimation

uses kthreads, these days the preferred interface for this is the
generic workqueue infrastructure.

Then, I can see patch:

 [PATCHv7 5/6] ipvs: add est_cpulist and est_nice sysctl vars

allows for CPU pinning which is also possible via sysfs.

Is there any particular reason for not using the generic workqueue
infrastructure? I could not find a reason in the commit logs.

Thanks.
