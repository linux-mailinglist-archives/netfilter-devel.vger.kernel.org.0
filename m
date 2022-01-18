Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A694928AD
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jan 2022 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiAROqF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jan 2022 09:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiAROqC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:46:02 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCBEC06161C
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Jan 2022 06:46:01 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u5so13469307ilq.9
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Jan 2022 06:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/WxInfrKGc7y2VA0cyOEt2NUpnfM44pn0Uxn8y3qOcc=;
        b=nikIQgJ+0+dlCEvagX1fZfX376c6fgCdUV2GlTpa412dLjTTawQ62IyQCp8G9WaymE
         aW5nupOgSPOsfGFvYFRo8BgDQrgUSiFeKGXV5N0tYzyC2o1svD4B2x/DNpAkGhMPn1xi
         WLLQAqeLwBKUWh04mjDJV23l7UBQlHULsURtRprY7EyFqXSuB3I9MKFrfalLpJW0aX7O
         ZCTlxL6nBSKQrURnIcV2UuApUlwbDjaVF/X2pkNNkspGNN4r7dj+k8b/nZwvWn0/ZjQt
         XCUM/IJ6ZbvLrS6JYyCp6a3ng1vVKmLppH0M9/3wL/5zKDLazxHzXonTcQ+LCvpoxncF
         2aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/WxInfrKGc7y2VA0cyOEt2NUpnfM44pn0Uxn8y3qOcc=;
        b=Cvy1/0KmLTcotOrS/VJdW5pYIBQoy7ynjFBa8OeB2JC1/vsqBc709NTbqdszjwosr3
         X6aNYxbSuGUhBunR6eB8CTLFmBY8v9W8QUpP/9UVe/+gz0B6ee58Ru1dBhLnuhubd6dm
         N6lMQd7kOBt3HPe30Rxs762+oYdlVL+jel0ifHNY7CQm0lc6hHNnPeKD9WIL3H/3cF1r
         zq1Eg2m+iw+NhWgLuM/trdQlt0AIrA5/saO/kmq5+cg4xYu2xaMJHBkIwTO0cwf3zG6N
         T2kQ4MNviLMo//y55QoRi6mHrYurb92qmtV/1VqF/rMIEgZDkmrySyfhw2cXYF/apjmU
         gOtA==
X-Gm-Message-State: AOAM531Ac8P0hUkLFYt+U51mUOyhqkekggDOJkyvuNUk29P5utIbMtgE
        LFvI5BXCEQCU4K20tXPbkMGjR0ltyVRxMNDp6iQ=
X-Google-Smtp-Source: ABdhPJw4oCeYcT9KAkl+VmAGFWQg3akZIZysE1bJcdZ0cVn3zjJCh7MGhIhGsVOgNXs4+Hde9FbwQpxABl+0wuuBpPk=
X-Received: by 2002:a05:6e02:1a0a:: with SMTP id s10mr14116846ild.260.1642517161233;
 Tue, 18 Jan 2022 06:46:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:156e:0:0:0:0 with HTTP; Tue, 18 Jan 2022 06:46:00
 -0800 (PST)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <awochambers004@gmail.com>
Date:   Tue, 18 Jan 2022 06:46:00 -0800
Message-ID: <CAH2diS41T1ec3yvVWUBUnV-tjJM-=d-anOqmB3DZ_ezZAfm7jg@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Prosz=C4=99 o uwag=C4=99,

Jestem Pan Abraham Morrison, Jak si=C4=99 masz, mam nadziej=C4=99, =C5=BCe =
jeste=C5=9B
zdrowy i zdrowy? Informuj=C4=99, =C5=BCe uda=C5=82o mi si=C4=99 zako=C5=84c=
zy=C4=87 transakcj=C4=99 z
pomoc=C4=85 nowego partnera z Indii i teraz =C5=9Brodki zosta=C5=82y przela=
ne do
Indii na konto bankowe nowego partnera.

W mi=C4=99dzyczasie zdecydowa=C5=82em si=C4=99 zrekompensowa=C4=87 ci sum=
=C4=99 500 000 $
(tylko pi=C4=99=C4=87set tysi=C4=99cy dolar=C3=B3w ameryka=C5=84skich) z po=
wodu twoich
wcze=C5=9Bniejszych wysi=C5=82k=C3=B3w, chocia=C5=BC mnie rozczarowa=C5=82e=
=C5=9B. Niemniej jednak
bardzo si=C4=99 ciesz=C4=99 z pomy=C5=9Blnego zako=C5=84czenia transakcji b=
ez =C5=BCadnego
problemu i dlatego postanowi=C5=82em zrekompensowa=C4=87 Ci kwot=C4=99 500 =
000 $,
aby=C5=9B podzieli=C5=82 si=C4=99 ze mn=C4=85 rado=C5=9Bci=C4=85.

Radz=C4=99 skontaktowa=C4=87 si=C4=99 z moj=C4=85 sekretark=C4=85 w sprawie=
 karty bankomatowej
o warto=C5=9Bci 500 000,00 $, kt=C3=B3r=C4=85 zachowa=C5=82em dla Ciebie. S=
kontaktuj si=C4=99 z
ni=C4=85 teraz bez zw=C5=82oki.

Imi=C4=99: Linda Koffi
E-mail: koffilinda785@gmail.com


Uprzejmie potwierd=C5=BA jej nast=C4=99puj=C4=85ce informacje:

Twoje pe=C5=82ne imi=C4=99:........
Tw=C3=B3j adres:..........
Tw=C3=B3j kraj:..........
Tw=C3=B3j wiek:.........
Tw=C3=B3j zaw=C3=B3d:..........
Tw=C3=B3j numer telefonu kom=C3=B3rkowego:..........
Tw=C3=B3j paszport lub prawo jazdy:........

Pami=C4=99taj, =C5=BCe je=C5=9Bli nie prze=C5=9Blesz jej powy=C5=BCszych in=
formacji
kompletnych, nie wyda ci karty bankomatowej, poniewa=C5=BC musi si=C4=99
upewni=C4=87, =C5=BCe to ty. Popro=C5=9B j=C4=85, aby przes=C5=82a=C5=82a C=
i =C5=82=C4=85czn=C4=85 sum=C4=99 (500 000
USD) karty bankomatowej, kt=C3=B3r=C4=85 dla Ciebie zachowa=C5=82em.

Z wyrazami szacunku,

Pan Abraham Morrison
