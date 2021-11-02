Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F8442D60
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Nov 2021 13:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBMER (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Nov 2021 08:04:17 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60528 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhKBMER (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:04:17 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 31B99605BA;
        Tue,  2 Nov 2021 12:59:49 +0100 (CET)
Date:   Tue, 2 Nov 2021 13:01:38 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [libnetfilter_log PATCH] build: fix pkg-config syntax-errors
Message-ID: <YYEooqEED/HI87z9@salvia>
References: <20211030121546.1072767-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211030121546.1072767-1-jeremy@azazel.net>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Oct 30, 2021 at 01:15:46PM +0100, Jeremy Sowden wrote:
> pkg-config config-files require back-slashes when definitions are folded
> across multiple lines.

Applied, thanks.
