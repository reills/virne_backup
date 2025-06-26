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
  id 647
  arrival_time 13673.517835003287
  lifetime 1865.0203411250736
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 48
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 1
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 36
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 45
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 42
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 47
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 32
    rom 7
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 28
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 47
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 33
    rom 12
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 22
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 40
    gpu 22
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
  edge [
    source 7
    target 8
    bw 7
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
]
