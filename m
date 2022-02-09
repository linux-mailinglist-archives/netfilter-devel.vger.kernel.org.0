Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2994AF0C1
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Feb 2022 13:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiBIMHI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Feb 2022 07:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiBIMFz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:05:55 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 610FAC1038EC;
        Wed,  9 Feb 2022 03:04:31 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2DEA7601C5;
        Wed,  9 Feb 2022 12:04:20 +0100 (CET)
Date:   Wed, 9 Feb 2022 12:04:28 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH nf-next] nfqueue: enable to set skb->priority
Message-ID: <YgOfvIsbOleXJTsU@salvia>
References: <Yfy2qiiYEeWLe8sI@salvia>
 <20220204102143.4010-1-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204102143.4010-1-nicolas.dichtel@6wind.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 04, 2022 at 11:21:43AM +0100, Nicolas Dichtel wrote:
> This is a follow up of the previous patch that enables to get
> skb->priority. It's now posssible to set it also.

Applied.
