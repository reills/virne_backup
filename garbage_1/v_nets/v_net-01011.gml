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
  id 1011
  arrival_time 21573.891405139035
  lifetime 529.5134888882872
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 11
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 14
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 32
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 0
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 4
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 48
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 14
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 25
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 39
    rom 35
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 0
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 7
  ]
]
