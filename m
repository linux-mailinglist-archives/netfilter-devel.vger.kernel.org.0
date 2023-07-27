Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB71765570
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jul 2023 15:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjG0N6a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jul 2023 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjG0N63 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:58:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8905430CF;
        Thu, 27 Jul 2023 06:58:28 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qP1VZ-0003OL-KQ; Thu, 27 Jul 2023 15:58:25 +0200
Date:   Thu, 27 Jul 2023 15:58:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Netfilter Development Mailing List 
        <netfilter-devel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH netfilter] netfilter: nfnetlink_log: always add a
 timestamp
Message-ID: <20230727135825.GF2963@breakpoint.cc>
References: <20230725085443.2102634-1-maze@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725085443.2102634-1-maze@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Maciej Żenczykowski <maze@google.com> wrote:
> Compared to all the other work we're already doing to deliver
> an skb to userspace this is very cheap - at worse an extra
> call to ktime_get_real() - and very useful.

Reviewed-by: Florian Westphal <fw@strlen.de>
