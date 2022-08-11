Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2558FC81
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Aug 2022 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiHKMkA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Aug 2022 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiHKMj7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:39:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6946A89808
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Aug 2022 05:39:56 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oM7Td-0002O2-3y; Thu, 11 Aug 2022 14:39:53 +0200
Date:   Thu, 11 Aug 2022 14:39:53 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Turritopsis Dohrnii Teo En Ming <tdtemccna@gmail.com>,
        netfilter-devel@vger.kernel.org, ceo@teo-en-ming-corp.com
Subject: Re: Upgrading iptables firewall on Red Hat Enterprise Linux 9.0
Message-ID: <YvT4mTK7T+yc3xcO@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Reindl Harald <h.reindl@thelounge.net>,
        Turritopsis Dohrnii Teo En Ming <tdtemccna@gmail.com>,
        netfilter-devel@vger.kernel.org, ceo@teo-en-ming-corp.com
References: <CACsrZYbEL+rdWL89cMD4LZT=MQOOoruTOCYYjHM+yeaXzv-YLw@mail.gmail.com>
 <YvTd+VWCXk/MVvYb@orbyte.nwl.cc>
 <41eaef5f-a7b0-7ff6-ad97-5a3901b8bfe0@thelounge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41eaef5f-a7b0-7ff6-ad97-5a3901b8bfe0@thelounge.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 11, 2022 at 01:13:13PM +0200, Reindl Harald wrote:
> Am 11.08.22 um 12:46 schrieb Phil Sutter:
> > Hi,
> > 
> > On Thu, Aug 11, 2022 at 03:49:41PM +0800, Turritopsis Dohrnii Teo En Ming wrote:
> >> Subject: Upgrading iptables firewall on Red Hat Enterprise Linux 9.0
> >>
> >> Good day from Singapore,
> >>
> >> The following RPM packages are installed on my Red Hat Enterprise
> >> Linux 9.0 virtual machine.
> >>
> >> iptables-libs-1.8.7-28.el9.x86_64
> >> iptables-nft-1.8.7-28.el9.x86_64
> >>
> >> Is it possible to upgrade iptables firewall to the latest version 1.8.8?
> > 
> > Of course, just download iptables tarball from netfilter.org[1] and
> > compile it yourself! ;)
> 
> besides that it's a terrible idea to randomly overwrite  distro files 
> one should have explained the OP that the actual firewall lives in the 
> kernel

I didn't suggest "to randomly overwrite distro files".

> so this update is pretty pointless unless you have to fix a specific 
> problem in the userland component

We don't know why OP wants v1.8.8. That aside, RHEL9 kernel is pretty
recent.

Cheers, Phil
