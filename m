Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F212D54E
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Dec 2019 01:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfLaAdO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Dec 2019 19:33:14 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50633 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbfLaAdO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Dec 2019 19:33:14 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 813B57EA686
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Dec 2019 11:33:00 +1100 (AEDT)
Received: (qmail 5608 invoked by uid 501); 31 Dec 2019 00:32:59 -0000
Date:   Tue, 31 Dec 2019 11:32:59 +1100
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     JH <jupiter.hce@gmail.com>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: Calling mnl_socket_sendto caused error of netlink attribute type
 1 has an invalid length
Message-ID: <20191231003259.GA1179@dimstar.local.net>
Mail-Followup-To: JH <jupiter.hce@gmail.com>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
References: <CAA=hcWTJWi3wcWez-adCE4NvzVbbeWSpwSNCz9cebnSDnGPtcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWTJWi3wcWez-adCE4NvzVbbeWSpwSNCz9cebnSDnGPtcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=RSmzAf-M6YYA:10 a=Y-OdJuiKx8yq0HztuukA:9 a=eA_Q5PU-Xkyl361y:21
        a=GZTTdauqWr3f-Rvg:21 a=CjuIK1q_8ugA:10
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 30, 2019 at 07:50:56PM +1100, JH wrote:
> Hi,
>
> I have following error of attribute type 1 has an invalid length when
> calling following mnl_socket_sendto(channel->mnlSocket, nlh,
> nlh->nlmsg_len), I cannot see what was wrong about it, the
> nlh->nlmsg_len = 40 which is from libnml, is that wrong? Please advise
> how to fix it.
>
> [ 3240.939609] netlink: 'wifi_signal': attribute type 1 has an invalid
> length. I have a WiFi function using nml API:
>
> typedef struct {
>         struct mnl_socket *mnlSocket;
>         char buf[BUFFER_SIZE];
>         uint16_t channelId;
>         uint32_t interfaceIndex;
>         uint32_t sequence;
>         void *context;
> } __attribute__ ((packed)) Netlink80211Channel_t;
>
> void WiFiScan::Send80211Message(struct nlmsghdr *nlh,
> Netlink80211Channel_t *channel) {
>     if (mnl_socket_sendto(channel->mnlSocket, nlh, nlh->nlmsg_len) < 0) {
>          std::cout << "Failed to send socket" << std::endl;
>     }
> }
>
> Thank you.
>
> - jh
>
The kernel is complaining about the content of the message, rather than the
length. The message you send should consist of a header followed by a series of
attributes. Attributes are of the form <type> <length> <data>. <type> is always
uint8_t. The kernel has seen the an attribute of type 1 (NLA_U8) but the
following lenth byte was not 1 as it should have been. Quite possibly the
message is garbage.

The error message you see is output by function validate_nla() in file
lib/nlattr.c at line 178.

To get a more helpful answer, you would need to post a lot more code. Is it on
gitbub?

Cheers ... Duncan.
