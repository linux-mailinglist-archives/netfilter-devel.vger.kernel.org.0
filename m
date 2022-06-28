Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9983D55EAD1
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jun 2022 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiF1RRK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jun 2022 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF1RRJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:17:09 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5461C2ED6E
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jun 2022 10:17:09 -0700 (PDT)
Date:   Tue, 28 Jun 2022 19:17:06 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables] Allow resetting the include search path
Message-ID: <Yrs3kkbc4z5AMF+W@salvia>
References: <20220627222304.93139-1-dxld@darkboxed.org>
 <Yrs2nn/amfnaUDk8@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yrs2nn/amfnaUDk8@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:13:05PM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Tue, Jun 28, 2022 at 12:23:04AM +0200, Daniel Gröber wrote:
> > Currently there is no way to disable searching in DEFAULT_INCLUDE_PATH
> > first. This is needed when testing nftables configurations spanning
> > multiple files without overwriting the globally installed ones.
> 
> You can do
> 
> # cat x.nft
> include "./z.nft"
> # cat z.nft
> add table x
> 
> then:
> 
> # nft -f x.nft
> 
> using ./ at the beginning of the path overrides DEFAULT_INCLUDE_PATH.

Absolute path also overrides DEFAULT_INCLUDE_PATH:

# cat x.nft
include "/foo/z.nft"

search_in_include_path() deals with this in scanner.l.

Relative path also overrides DEFAULT_INCLUDE_PATH.
