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
  id 833
  arrival_time 17346.12029429604
  lifetime 887.7192043779102
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 20
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 18
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 24
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 47
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 21
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 13
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 35
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 15
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 47
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 27
    rom 21
  ]
  node [
    id 10
    label "10"
    cpu 41
    gpu 30
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 34
    gpu 27
    rom 11
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 35
    rom 30
  ]
  node [
    id 13
    label "13"
    cpu 48
    gpu 28
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 28
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 13
  ]
  edge [
    source 11
    target 12
    bw 13
  ]
  edge [
    source 12
    target 13
    bw 49
  ]
]
