Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0921D636C59
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Nov 2022 22:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiKWV00 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Nov 2022 16:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiKWV0Z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:26:25 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD89C7660
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Nov 2022 13:26:24 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oxxG9-00044E-Rj; Wed, 23 Nov 2022 22:26:21 +0100
Date:   Wed, 23 Nov 2022 22:26:21 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 00/13] Extensions: Review xlate callbacks
Message-ID: <20221123212621.GD2753@breakpoint.cc>
References: <20221123164350.10502-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123164350.10502-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> This is a review of all extensions' xlate callbacks focussing on
> correctness of operation and return code.

Thanks, please push this out.
