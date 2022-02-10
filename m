Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7D4B11B7
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Feb 2022 16:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiBJPcc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Feb 2022 10:32:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239590AbiBJPcb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:32:31 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79969CE5
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Feb 2022 07:32:31 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5031C6019B;
        Thu, 10 Feb 2022 16:32:15 +0100 (CET)
Date:   Thu, 10 Feb 2022 16:32:28 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2] tests: iptables-test: Support variant
 deviation
Message-ID: <YgUwDLWCfCi1R1K/@salvia>
References: <20220209154107.25328-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209154107.25328-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:41:07PM +0100, Phil Sutter wrote:
> Some test results are not consistent between variants:
> 
> * CLUSTERIP is not supported with nft_compat, so all related tests fail
>   with iptables-nft.
> * iptables-legacy mandates TCPMSS be combined with SYN flag match,
>   iptables-nft does not care. (Or precisely, xt_TCPMSS.ko can't validate
>   match presence.)
> 
> Introduce an optional fourth test spec field to specify the variant it
> applies to. Consequently, the opposite result is expected with the other
> variant.

LGTM, thanks
