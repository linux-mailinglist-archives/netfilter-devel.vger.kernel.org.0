Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83F6EF9F1
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Apr 2023 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjDZSTY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Apr 2023 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbjDZSTX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:19:23 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED3C83D6
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Apr 2023 11:19:22 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1prjjc-0002jg-4T
        for netfilter-devel@vger.kernel.org; Wed, 26 Apr 2023 20:19:20 +0200
Date:   Wed, 26 Apr 2023 20:19:20 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/2] utils: nfbpf_compile: Replace
 pcap_compile_nopcap()
Message-ID: <ZElrKBsBnDnyDBpQ@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230421160409.7586-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421160409.7586-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 21, 2023 at 06:04:08PM +0200, Phil Sutter wrote:
> The function is deprecated. Eliminate the warning by use of
> pcap_open_dead(), pcap_compile() and pcap_close() just how
> pcap_compile_nopcap() is implemented internally in libpcap.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Series applied.
