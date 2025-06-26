graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 684
  arrival_time 14437.232756669058
  lifetime 123.86682110357914
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 18
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 9
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 22
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 10
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 35
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 36
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 28
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 26
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 43
    rom 34
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 31
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 11
    gpu 38
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 48
    gpu 44
    rom 18
  ]
  node [
    id 12
    label "12"
    cpu 19
    gpu 28
    rom 3
  ]
  node [
    id 13
    label "13"
    cpu 46
    gpu 23
    rom 26
  ]
  node [
    id 14
    label "14"
    cpu 36
    gpu 48
    rom 27
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 28
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 42
  ]
  edge [
    source 9
    target 10
    bw 21
  ]
  edge [
    source 10
    target 11
    bw 48
  ]
  edge [
    source 11
    target 12
    bw 22
  ]
  edge [
    source 12
    target 13
    bw 18
  ]
  edge [
    source 13
    target 14
    bw 24
  ]
]
