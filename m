Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9DF53E3A2
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jun 2022 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiFFIC6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jun 2022 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiFFICq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:02:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D571F2FFDE
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Jun 2022 01:02:42 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:02:33 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Scott Wisniewski <scott@scottdw2.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Expired Cert
Message-ID: <Yp20mQgBFfZ/kro3@salvia>
References: <CAO=7uoa2_4+soqK+9k+BJ4AjCbL3T7xQxNtKZ_VgRYi3ZpXb8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO=7uoa2_4+soqK+9k+BJ4AjCbL3T7xQxNtKZ_VgRYi3ZpXb8Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jun 05, 2022 at 12:43:37PM -0700, Scott Wisniewski wrote:
> Just a quick heads up, it looks like the cert used by
> 
> bugzilla.netfilter.org
> and
> people.netfilter.org
> 
> Expired back on 6/3. You might want to rotate the cert.

Fixed, thanks for reporting.
