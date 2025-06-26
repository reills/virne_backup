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
  id 510
  arrival_time 9717.329922179257
  lifetime 2115.6733766219486
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 11
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 39
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 29
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 14
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 30
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 35
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 23
    rom 32
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 43
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 20
    gpu 9
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 20
    rom 18
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 3
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 23
    rom 26
  ]
  node [
    id 12
    label "12"
    cpu 33
    gpu 19
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 47
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 33
  ]
  edge [
    source 9
    target 10
    bw 1
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
]
