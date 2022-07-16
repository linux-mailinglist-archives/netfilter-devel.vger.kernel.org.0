Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65F5576DA7
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 Jul 2022 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiGPL4e (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 16 Jul 2022 07:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPL4d (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 16 Jul 2022 07:56:33 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE9DB5
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Jul 2022 04:56:31 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oCgPM-0000og-Sd; Sat, 16 Jul 2022 13:56:28 +0200
Date:   Sat, 16 Jul 2022 13:56:28 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] parser_bison: bail out on too long names
Message-ID: <YtKnbGh/FdJHlil3@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20220716080549.162980-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716080549.162980-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sat, Jul 16, 2022 at 10:05:49AM +0200, Pablo Neira Ayuso wrote:
> If user specifies a too long object name, bail out.

Shouldn't this be done in eval phase or so? As-is, this patch introduces
a standard syntax-specific limitation people may circumvent using JSON,
no?

Cheers, Phil
