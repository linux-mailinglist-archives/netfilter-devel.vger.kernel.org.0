Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F1F40C7D6
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Sep 2021 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhIOPC1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Sep 2021 11:02:27 -0400
Received: from mail.netfilter.org ([217.70.188.207]:56940 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhIOPC1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:02:27 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id B87AE6000D;
        Wed, 15 Sep 2021 16:59:54 +0200 (CEST)
Date:   Wed, 15 Sep 2021 17:01:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf] netfilter: ip6_tables: zero-initialize fragment offset
Message-ID: <20210915150103.GA19119@salvia>
References: <20210912212433.45389-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210912212433.45389-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Sep 12, 2021 at 10:24:33PM +0100, Jeremy Sowden wrote:
> ip6tables only sets the `IP6T_F_PROTO` flag on a rule if a protocol is
> specified (`-p tcp`, for example).  However, if the flag is not set,
> `ip6_packet_match` doesn't call `ipv6_find_hdr` for the skb, in which
> case the fragment offset is left uninitialized and a garbage value is
> passed to each matcher.

Applied, thanks.
