Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF27C4E62F1
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Mar 2022 13:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349940AbiCXMLD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Mar 2022 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCXMLC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:11:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B572FA8884;
        Thu, 24 Mar 2022 05:09:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d10so8692700eje.10;
        Thu, 24 Mar 2022 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=67MXo1aMhvDYPdJZM5L7/bTsYDHo83mYbC1B3w+pFmU=;
        b=NVfnhBjf2cNRWv7VdnLwj459SDVzhkBuRf2JVF05+z7Y8jd4DnKU//emVkjuKJsIEi
         DKM5na5sKS/QYbzshP9VnUCqGea78zm2dxbOxmL9xyZXtq89imrUG1P/x0OzfCamegws
         vFRZaW1It2njxpFEDZPrL9w5gcfaW4V1RsfMMPMYud9um0Go8b0yLBcL43TKWxXgudO7
         9nEx/pSIh8txj8YhoTj0bbSeRsxcb7b6gHdk0WPfBYNBBLe+vhueLMKNio1nzusZi5g0
         OgKAwiTUnhqBun9Zib9mquOKP59XNVyV+b+odDkaLrmB8A6KKHMnvK59GeNQXjyOhYF/
         EIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=67MXo1aMhvDYPdJZM5L7/bTsYDHo83mYbC1B3w+pFmU=;
        b=F1yd0292dKcmaIi7V8NIPGPN3pigdGiNwmkUUn1APHhLLQBVtCAL8SNdg9ytTm5IXr
         3JopjDPlWUmSyCokmjCgWgrflJWkBB7R0av9CQ8g74oKAGwh84ercOZGNe5znnCx17Yt
         xGjKUmAbyJ+QPer1O14Tuatw1bQi8hmuxEKnhRxPvgasaD6bjHqLYmqcG1xTubOZ9bn7
         uX1dkaB885vE2GhPFLkziTo+n9fvM/jtOS3KoKJ5E/cRk+GMGx8EWblkK+HTCzfSr6Nj
         7J7FHCc5JeE7YmqUAnDORKF8lcI1pAwAmylmjpdNNk2+M30IUs2xwqCBw4Ek+6oDDWz2
         vakg==
X-Gm-Message-State: AOAM530RFPaillNCpUSr2NRYDwATjAjRYybBRPI5KeWc/ZJL89M+MxFd
        DXPtZiABGDjEPxn1+kuxTDc=
X-Google-Smtp-Source: ABdhPJw6SIs+zHoj+EjiHJSVxgR0LcJ/AoNSdYbve2p/jC0fX/2pxAPYO2bi7Uru+yp898BPELZ2XQ==
X-Received: by 2002:a17:907:c00b:b0:6df:cd40:afc4 with SMTP id ss11-20020a170907c00b00b006dfcd40afc4mr5261812ejc.629.1648123768003;
        Thu, 24 Mar 2022 05:09:28 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id l2-20020aa7cac2000000b003f9b3ac68d6sm1371270edt.15.2022.03.24.05.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Mar 2022 05:09:26 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: bug report and future request 
From:   Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <FE0EEED5-48C9-412F-81BA-0028818C2EE8@gmail.com>
Date:   Thu, 24 Mar 2022 14:09:25 +0200
Cc:     netfilter <netfilter@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB57EE0F-F4CE-4198-89E0-F25ED3C321A5@gmail.com>
References: <AE6DAC96-EC3E-43C9-A95A-B230842DD7B1@gmail.com>
 <20220321212750.GB24574@breakpoint.cc>
 <4B0C8933-C7D8-49BA-B7F2-29625B0865C1@gmail.com>
 <20220322103203.GD24574@breakpoint.cc>
 <04C4931B-553E-4FEA-85D4-B3E186520EE5@gmail.com>
 <FE0EEED5-48C9-412F-81BA-0028818C2EE8@gmail.com>
To:     Florian Westphal <fw@strlen.de>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

One more update=20

I try to make rule for limiter in offload mode :

table inet nft-qos-static {
        set limit_ul {
                typeof ip saddr
                flags dynamic
        }
        set limit_dl {
                typeof ip daddr
                flags dynamic
        }

        chain upload {
                type filter hook prerouting priority filter ; policy =
accept;
                ip saddr @limit_ul drop;
        }

        chain download {
                type filter hook postrouting priority filter; policy =
accept;
                ip daddr @limit_dl drop;

        }
        flowtable fastnat {
                hook ingress priority filter; devices =3D { eth0, eth1 =
};
        }
        chain forward {
                type filter hook forward priority filter; policy accept;
                ip protocol { tcp , udp } flow offload @fastnat;
        }
}



its not work perfect only upload limit work , download get full channel=20=


in test i set 100mbit up/down  upload is stay on ~100mbit , but download =
up to 250-300mbit (i have this limit be my isp).

the problem is limiter work only for Upload , is it posible to make work =
on download rule ?

Martin

> On 24 Mar 2022, at 9:52, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> HI all
>=20
> One more after switch to all rule and use only nft (remove qdisc from =
kernel config, and remove all iptables tables) in perf top see =
nft_do_chain is up to 3-4% on all core and if isolate with perf top -C X =
i see on one core is up to 10-15% :
>=20
>  31.26%  [pppoe]                  [k] pppoe_rcv
>     3.19%  [nf_tables]              [k] nft_do_chain
>     2.46%  [kernel]                 [k] =
__netif_receive_skb_core.constprop.0
>     2.18%  [kernel]                 [k] fib_table_lookup
>     2.07%  [i40e]                   [k] i40e_clean_rx_irq
>     1.51%  [kernel]                 [k] __dev_queue_xmit
>     1.23%  [kernel]                 [k] dev_queue_xmit_nit
>     1.23%  [nf_conntrack]           [k] __nf_conntrack_find_get.isra.0
>     1.20%  [kernel]                 [k] __copy_skb_header
>     1.19%  [kernel]                 [k] kmem_cache_free
>     1.17%  [kernel]                 [k] skb_release_data
>     1.06%  [nf_tables]              [k] nft_rhash_lookup=20
>=20
>=20
> Is have options to optimize work of nft rule set.
>=20
> and for second question is it posible to make work this limiter in =
flow table rule set :=20
>=20
> #table inet filter {
> #        flowtable fastnat {
> #                hook ingress priority 0; devices =3D { eth0, eth1 };
> #        }
> #
> #        chain forward {
> #                type filter hook forward priority 0; policy accept;
> #                ip protocol { tcp , udp } flow offload @fastnat;
> #        }
> #}
>=20
> Like this and if have options to make devices list dynamic to add =
device automatic or to add device with *=20
> If limiter work in flow table will make offload traffic and reduce cpu =
load
>=20
> Martin
>=20
>> On 23 Mar 2022, at 0:55, Martin Zaharinov <micron10@gmail.com> wrote:
>>=20
>> Hi Florian
>>=20
>> yes now work perfect
>> i will test with 1-4k ips to see performance vs qdisc or iptables.
>>=20
>> for second offload question:
>>=20
>> is it possible to make limiter work in offload mode and ia it posible =
to add dynamic interface like ppp* or vlan* or other type.
>>=20
>>=20
>>=20
>> P.S.
>>=20
>> thanks for fast reply for first part!
>>=20
>> P.S.2=20
>>=20
>> resend mail to netfilter group
>>=20
>> Martin
>>=20
>>> On 22 Mar 2022, at 12:32, Florian Westphal <fw@strlen.de> wrote:
>>>=20
>>> Martin Zaharinov <micron10@gmail.com> wrote:
>>>> Hi Florian
>>>>=20
>>>> Look good this config but not work after set user not limit by =
speed.
>>>=20
>>> Works for me.  Before:
>>> [ ID] Interval           Transfer     Bitrate         Retr
>>> [  5]   0.00-10.00  sec  5.09 GBytes  4.37 Gbits/sec    0 sender
>>> [  5]   0.00-10.00  sec  5.08 GBytes  4.36 Gbits/sec receiver
>>>=20
>>> After:
>>> [  5]   0.00-10.00  sec  62.9 MBytes  52.7 Mbits/sec    0 sender
>>> [  5]   0.00-10.00  sec  59.8 MBytes  50.1 Mbits/sec receiver
>>>=20
>>>> table inet nft-qos-static {
>>>>      set limit_ul {
>>>>              typeof ip saddr
>>>>              flags dynamic
>>>>              elements =3D { 10.0.0.1 limit rate over 5 =
mbytes/second burst 6000 kbytes, 10.0.0.254 limit rate over 12 =
mbytes/second burst 6000 kbytes }
>>>>      }
>>>> 		set limit_dl {
>>>>              typeof ip saddr
>>>>              flags dynamic
>>>>              elements =3D { 10.0.0.1 limit rate over 5 =
mbytes/second burst 6000 kbytes, 10.0.0.254 limit rate over 12 =
mbytes/second burst 6000 kbytes }
>>>>     }
>>>>=20
>>>>      chain upload {
>>>> 			type filter hook postrouting priority filter; =
policy accept;
>>>> 			ip saddr @limit_ul drop
>>>>      }
>>>> 		chain download {
>>>> 			type filter hook prerouting priority filter; =
policy accept;
>>>> 			ip saddr @limit_dl drop
>>>> 		}
>>>=20
>>> daddr?
>>>=20
>>>> With this config user with ip 10.0.0.1 not limited to 5 mbytes ,=20
>>>=20
>>>> When back to this config :
>>>>=20
>>>> table inet nft-qos-static {
>>>> 	chain upload {
>>>> 		type filter hook postrouting priority filter; policy =
accept;
>>>> 		ip saddr 10.0.0.1 limit rate over 5 mbytes/second burst =
6000 kbytes drop
>>>> 	}
>>>>=20
>>>> 	chain download {
>>>> 		type filter hook prerouting priority filter; policy =
accept;
>>>> 		ip daddr 10.0.0.1 limit rate over 5 mbytes/second burst =
6000 kbytes drop
>>> 	           ~~~~~
>>=20
>=20

