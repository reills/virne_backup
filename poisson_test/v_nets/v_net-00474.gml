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
  id 474
  arrival_time 8849.747376050143
  lifetime 148.1574650142715
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 40
    gpu 19
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 39
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 5
    gpu 0
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 25
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 41
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 17
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 26
    rom 14
  ]
  node [
    id 7
    label "7"
    cpu 33
    gpu 35
    rom 50
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 35
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 46
    gpu 6
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
]
