Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80E13D80FE
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jul 2021 23:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhG0VLV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Jul 2021 17:11:21 -0400
Received: from mail.netfilter.org ([217.70.188.207]:36494 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhG0VLV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:11:21 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 993E3605D7;
        Tue, 27 Jul 2021 23:10:50 +0200 (CEST)
Date:   Tue, 27 Jul 2021 23:11:16 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [nft] Regarding `tcp flags` (and a potential bug)
Message-ID: <20210727211116.GA13897@salvia>
References: <CAGnHSEkt4xLAO_T9KNw2xGjjvC4y=E0LjX-iAACUktuCy0J7gw@mail.gmail.com>
 <CAGnHSEncHuO2BduzGx1L9eVtAozdGb-XabQyrS7S+CO2swa1dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGnHSEncHuO2BduzGx1L9eVtAozdGb-XabQyrS7S+CO2swa1dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:52:39PM +0800, Tom Yan wrote:
> Just noticed something that is even worse:
> 
> # nft add rule meh tcp_flags 'tcp flags { fin, rst, ack }'
> # nft add rule meh tcp_flags 'tcp flags == { fin, rst, ack }'
> # nft add rule meh tcp_flags 'tcp flags & ( fin | rst | ack ) != 0'
> # nft add rule meh tcp_flags 'tcp flags & ( fin | rst | ack ) == 0'
> # nft list table meh
> table ip meh {
>     chain tcp_flags {
>         tcp flags { fin, rst, ack }
>         tcp flags { fin, rst, ack }
>         tcp flags fin,rst,ack
>         tcp flags ! fin,rst,ack
>     }
> }

Could you develop the issue you're seeing here?
