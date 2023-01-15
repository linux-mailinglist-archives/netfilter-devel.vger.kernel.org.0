Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8266AF95
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Jan 2023 08:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjAOHNv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Jan 2023 02:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAOHNt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Jan 2023 02:13:49 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ADC9A5D2
        for <netfilter-devel@vger.kernel.org>; Sat, 14 Jan 2023 23:13:48 -0800 (PST)
Date:   Sun, 15 Jan 2023 08:13:42 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     Phil Sutter <phil@netfilter.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [ANNOUNCE] iptables 1.8.9 release
Message-ID: <Y8Onpi8LqsWIX06f@salvia>
References: <Y7/s83d8D0z1QYt1@orbyte.nwl.cc>
 <e0357e53-8eda-9d9d-d1d6-4f8669759181@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0357e53-8eda-9d9d-d1d6-4f8669759181@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Arturo,

On Sat, Jan 14, 2023 at 10:18:56PM +0100, Arturo Borrero Gonzalez wrote:
> On 1/12/23 12:20, Phil Sutter wrote:
> > Hi!
> > 
> > The Netfilter project proudly presents:
> > 
> >          iptables 1.8.9
> > 
> 
> Hi Phil,
> 
> thanks for the release!
> 
> I see the tarball includes now a etc/xtables.conf file [0]. Could you please clarify the expected usage of this file?
> 
> Do we intend users to have this in their systems? If so, what for.
> It appears to be in nftables native format, so who or what mechanisms would be responsible for reading it in a system that
> has no nftables installed?
> 
> Perhaps the file is only useful for development purposes?

I think this file just slipped through while enabling `make distcheck'
in a recent update, but let's wait for Phil to confirm this.
