Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B816558FADB
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Aug 2022 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiHKKqX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Aug 2022 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiHKKqV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:46:21 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5846923D6
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Aug 2022 03:46:19 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oM5hh-0001ES-2F; Thu, 11 Aug 2022 12:46:17 +0200
Date:   Thu, 11 Aug 2022 12:46:17 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Turritopsis Dohrnii Teo En Ming <tdtemccna@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, ceo@teo-en-ming-corp.com
Subject: Re: Upgrading iptables firewall on Red Hat Enterprise Linux 9.0
Message-ID: <YvTd+VWCXk/MVvYb@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Turritopsis Dohrnii Teo En Ming <tdtemccna@gmail.com>,
        netfilter-devel@vger.kernel.org, ceo@teo-en-ming-corp.com
References: <CACsrZYbEL+rdWL89cMD4LZT=MQOOoruTOCYYjHM+yeaXzv-YLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsrZYbEL+rdWL89cMD4LZT=MQOOoruTOCYYjHM+yeaXzv-YLw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Aug 11, 2022 at 03:49:41PM +0800, Turritopsis Dohrnii Teo En Ming wrote:
> Subject: Upgrading iptables firewall on Red Hat Enterprise Linux 9.0
> 
> Good day from Singapore,
> 
> The following RPM packages are installed on my Red Hat Enterprise
> Linux 9.0 virtual machine.
> 
> iptables-libs-1.8.7-28.el9.x86_64
> iptables-nft-1.8.7-28.el9.x86_64
> 
> Is it possible to upgrade iptables firewall to the latest version 1.8.8?

Of course, just download iptables tarball from netfilter.org[1] and
compile it yourself! ;)

Cheers, Phil

[1] https://www.netfilter.org/pub/iptables/iptables-1.8.8.tar.bz2
