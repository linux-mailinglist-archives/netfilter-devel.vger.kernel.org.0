Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453284C2E15
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Feb 2022 15:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiBXOSx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Feb 2022 09:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiBXOSx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:18:53 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEA9294FFF
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Feb 2022 06:18:23 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nNEwn-0004lA-Sa; Thu, 24 Feb 2022 15:18:21 +0100
Date:   Thu, 24 Feb 2022 15:18:21 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Robert Marko <robimarko@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] conntrack: fix build with kernel 5.15 and musl
Message-ID: <20220224141821.GE28705@breakpoint.cc>
References: <20220224140111.2011488-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224140111.2011488-1-robimarko@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Robert Marko <robimarko@gmail.com> wrote:
> Currently, with kernel 5.15 headers and musl building is failing with
> redefinition errors due to a conflict between the kernel and musl headers.

Applied to libnetfilter-conntrack, thanks.
