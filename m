Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3669F85C
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Feb 2023 16:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjBVPzK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Feb 2023 10:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjBVPzJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:55:09 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3FA3B3EA
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Feb 2023 07:55:08 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pUrSU-0004Yi-L1; Wed, 22 Feb 2023 16:55:06 +0100
Date:   Wed, 22 Feb 2023 16:55:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Thomas Devoogdt <thomas@devoogdt.com>,
        netfilter-devel@vger.kernel.org,
        Thomas Devoogdt <thomas.devoogdt@barco.com>
Subject: Re: [PATCH] [iptables] extensions: libxt_LOG.c: fix
 linux/netfilter/xt_LOG.h include on Linux < 3.4
Message-ID: <Y/Y62lQorHG1PK2g@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Thomas Devoogdt <thomas@devoogdt.com>,
        netfilter-devel@vger.kernel.org,
        Thomas Devoogdt <thomas.devoogdt@barco.com>
References: <20230222072349.509917-1-thomas.devoogdt@barco.com>
 <Y/XouZlrtw/SN/C2@salvia>
 <Y/YFcwp/gyZY5Pmw@orbyte.nwl.cc>
 <Y/YZC1Feu9gOCdWF@salvia>
 <Y/Y1efOjGyBo0MAj@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Y1efOjGyBo0MAj@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 22, 2023 at 04:32:09PM +0100, Phil Sutter wrote:
[...]
> I'll apply Thomas' patch adding a reference to my commit and follow up
> with bpf header copy (unless someone objects).

Scratch the BPF header copy idea - bpf.h is 260KB and libxt_bpf.c acts
accordingly if missing (I just missed calling configure when playing
around).
