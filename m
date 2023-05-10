Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD06FD7DE
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 09:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbjEJHJm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 03:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjEJHJl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 03:09:41 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D30D4486
        for <netfilter-devel@vger.kernel.org>; Wed, 10 May 2023 00:09:40 -0700 (PDT)
Date:   Wed, 10 May 2023 09:09:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     netfilter-devel@vger.kernel.org,
        Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH nf-next v2 0/4] selftest: netfilter: small test tweaks
Message-ID: <ZFtDLg1Ov1IXJXbt@calendula>
References: <20230504084814.41487-1-boris.sukholitko@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504084814.41487-1-boris.sukholitko@broadcom.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 04, 2023 at 11:48:10AM +0300, Boris Sukholitko wrote:
> Hi,
> 
> These patches allow nft_flowtable.sh test script to work in busybox environment
> (patches 1-2).
> 
> More exact wait for netcat running in the background is in patch 3.
> 
> Small adaptive sleep optimization (patch 4) helps with running on busy servers
> and cuts default sleep time a bit.

Thanks, I am going to route this batch through nf.git instead, I think
it is good to get this selftests updates there.
